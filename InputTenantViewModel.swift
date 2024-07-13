import SwiftUI

class InputTenantViewModel: ObservableObject {
    
    @Published var language: AppLanguage.Language = .ru
    @Published var showAlert: Bool = false
    @Published var showAuhtView: Bool = false
    @Published var codeTenant: String = ""
    
    let networkServices = NetworkServices()
    var textError: String = ""
    
    func changeLanguage(language: AppLanguage.Language) {
        self.language = AppLanguage.changeLanguage(language: language)
    }
    
    func sendCode() {
        if codeTenant.isEmpty {
            textError = ErrorParser.shared.parse(detail: "need_enter_tenant_code")
            DispatchQueue.main.async {
                self.showAlert = true
            }
        } else {
            Task {
                let code = codeTenant.replacingOccurrences(of: " ", with: "").lowercased()
                let json = await networkServices.sendCodeTenant(codeTenant: code)
                if let detail = json?["detail"].string {
                    textError = ErrorParser.shared.parse(detail: detail)
                    DispatchQueue.main.async {
                        self.showAlert = true
                    }
                } else {
                    // сохранение кода тенанта и host
                    // кода тенанта сохраняется для отображения в меню
                    do {
                        try LocalStorage.keychain.set(codeTenant, key: String._codeTenant)
                        try LocalStorage.keychain.set(json!["domain"].stringValue, key: String._hostname)
                    }
                    Endpoint.hostname = json!["domain"].stringValue
                    getOptionsTenant()
                }
            }
        }
    }
    
    private func getOptionsTenant() {
        Task(priority: .userInitiated) {
            LocalStorage.Parameters._optionsTenant = await networkServices.getOptionsTenant()
            if LocalStorage.Parameters._optionsTenant != nil {
                DispatchQueue.main.async {
                    self.codeTenant = ""
                    self.showAuhtView = true
                }
            }
        }
    }
}

import SwiftUI

class InputTenantViewModel: ObservableObject {
    
    @Published var language: AppLanguage.Language = .ru
    @Published var showAlert: Bool = false
    @Published var showAuhtView: Bool = false
    @Published var codeTenant: String = "test-1"
    
    let networkServices = NetworkServices()
    var textError: String = ""
    
    func changeLanguage(language: AppLanguage.Language) {
        DispatchQueue.main.async {
            self.language = AppLanguage.changeLanguage(language: language)
        }
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
                    print("сохранение кода тенанта и host")
                    LocalServices.saveInKeychain(value: codeTenant, key: ._codeTenant)
                    LocalServices.saveInKeychain(value: json!["domain"].stringValue, key: ._hostname)
                    Endpoint.hostname = json!["domain"].stringValue
                    getOptionsTenant()
                }
            }
        }
    }
    
    private func getOptionsTenant() {
        Task(priority: .userInitiated) {
            let json = await networkServices.getOptionsTenant()
            if json != nil {
                LocalServices.saveOptionsTenant(json: json)
                DispatchQueue.main.async {
                    self.showAuhtView = true
                }
            }
        }
    }
}

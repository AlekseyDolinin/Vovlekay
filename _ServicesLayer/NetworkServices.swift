import Foundation
import SwiftUI
import Combine

class NetworkServices: ObservableObject {
        
    static let shared = NetworkServices()
        
    @Published var json: JSON? = nil
        
    let nm = NetworkManager()
    
    func sendCodeTenant(codeTenant: String) {
        let link = Endpoint.path(.sendTenantCode(code: codeTenant))
        print("link: \(link)")
        Task(priority: .userInitiated) {
            json = await nm.getJSON(link: link)
            print("json_1: \(json)")
            // сохранение кода тенанта для отображения в меню
//            UserDefaults.standard.set(codeTenant, forKey: .codeTenant)
//            UserDefaults.standard.set(json!["domain"].string, forKey: .hostname)
//            Endpoint.hostname = json!["domain"].stringValue
//            DispatchQueue.main.async {
//                print("loadDataForStart!!!!!!")
//            }
        }
    }
}

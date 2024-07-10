import Foundation
import SwiftUI
import Combine

final class NetworkServices: ObservableObject {
                
    let networkManager = NetworkManager()
    
    func sendCodeTenant(codeTenant: String) async -> JSON? {
        let link = Endpoint.path(.sendTenantCode(code: codeTenant))
        let json = await networkManager.getJSON(link: link)
        return json
    }
    
    func getOptionsTenant() async -> JSON? {
        let link = Endpoint.path(.getOptionsTenant)
        let json = await networkManager.getJSON(link: link)
        return json
    }
    
    func getColorShemeTenant() {
        
    }
    
    func getLanguageDictionary() {
        
    }
    
    func getUserData() {
        
    }
    
}

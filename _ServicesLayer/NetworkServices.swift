import Foundation
import SwiftUI
import Combine

final class NetworkServices: ObservableObject {
                
    static let shared = NetworkServices()
    
    let networkManager = NetworkManager()
    
    func sendCodeTenant(codeTenant: String) async -> JSON? {
        let link = Endpoint.path(.sendTenantCode(code: codeTenant))
        return await networkManager.getJSON(link: link)
    }
    
    func getOptionsTenant() async -> JSON? {
        let link = Endpoint.path(.getOptionsTenant)
        return await networkManager.getJSON(link: link)
    }
    
    func getColorShemeTenant() async -> JSON? {
        let link = Endpoint.path(.getColorShemeTenant)
        print("link: \(link)")
        return await networkManager.getJSON(link: link)
    }
    
    func getLanguageDictionary() async -> JSON? {
        let link = Endpoint.path(.getLanguageDictionary)
        return await networkManager.getJSON(link: link)
    }
    
    func getUserData() async -> JSON? {
        let link = Endpoint.path(.getUserData)
        return await networkManager.getJSON(link: link)
    }
    
}

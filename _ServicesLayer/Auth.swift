import Foundation
import KeychainAccess

class Auth {
    
    /// Проверка авторизации
    /// true - авторизация пройдена
    /// false - авторизация не пройдена
    class func checkAuth() -> Bool {
        print("checkAuth")
        
        let name = LocalStorage.keychain["name"]
        let value = LocalStorage.keychain["value"]
        
        print(name)
        print(value)
        
        if name == nil && value == nil {
            return false
        } else {
            // keychain remove
            do {
                try LocalStorage.keychain.remove("name")
                try LocalStorage.keychain.remove("value")
                print("keychain is clear")       
            } catch let error {
                print("error remove keychain: \(error)")
            }
            return true
        }
    }
}

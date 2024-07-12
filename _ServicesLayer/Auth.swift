import Foundation
import KeychainAccess

class Auth {
    
    /// Проверка авторизации
    /// true - авторизация пройдена
    /// false - авторизация не пройдена
    class func checkAuth() -> Bool {
        
        let name = LocalStorage.keychain["name"]
        let value = LocalStorage.keychain["value"]
        
        // если сохранены name и value из cookies то пользователь авторизован
        // актуальность value проверится при первом запросе
        if name == nil && value == nil {
            return false
        } else {
            // keychain remove
            LocalStorage.Cookies.removeCookiesFromKeychain()
            return true
        }
    }
}

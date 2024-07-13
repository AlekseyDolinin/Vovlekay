import Foundation
import KeychainAccess

class Auth {
    /// Проверка авторизации
    /// true - авторизация пройдена
    /// false - авторизация не пройдена
    class func checkAuth() -> Bool {
        let name = LocalStorage.keychain[String._cookieName]
        let value = LocalStorage.keychain[String._cookieValue]
        let hostname = LocalStorage.keychain[String._hostname]
        //
        if let hostname_ = hostname {
            Endpoint.hostname = hostname_
        }
        // если сохранены name и value из cookies и hostname то пользователь авторизован
        // актуальность value проверится при первом запросе
        if name == nil || value == nil || hostname == nil {
            return false
        } else {
            return true
        }
    }
}

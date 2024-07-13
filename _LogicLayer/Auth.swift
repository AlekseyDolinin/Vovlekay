import Foundation
import KeychainAccess

class Auth {
    /// Проверка авторизации
    /// true - авторизация пройдена
    /// false - авторизация не пройдена
    class func checkAuth() -> Bool {
        
        let cookie = LocalServices.getCookie()
        let hostName = LocalServices.getHostname()        
        //
        if let hostName_ = hostName {
            Endpoint.hostname = hostName_
        }
        // если сохранены name и value из cookies и hostname то пользователь авторизован
        // актуальность value проверится при первом запросе
        if cookie.name == nil || cookie.value == nil || hostName == nil {
            return false
        } else {
            return true
        }
    }
}

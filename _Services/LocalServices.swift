import SwiftUI

class LocalServices: ObservableObject {
                        
    static let localStorage = LocalStorage()
    
    class func clearLocalStorage() {
        LocalStorage.clearAllLocalStorage()
    }
    
    class func saveInKeychain(value: String, key: KeyskKeychain) {
        LocalStorage.saveValue(value: value, key: key)
    }
    
    class func saveOptionsTenant(json: JSON?) {
        LocalStorage.shared._optionsTenant = json
    }
    
    class func getOptionsTenant() -> JSON? {
        return LocalStorage.shared._optionsTenant
    }
    
    class func getCodeTenant() -> String? {
        return LocalStorage.shared.keychain[KeyskKeychain._codeTenant.rawValue]
    }
    
    class func getHostname() -> String? {
        return LocalStorage.shared.keychain[KeyskKeychain._hostname.rawValue]
    }
    
    class func getCookie() -> (name: String?, value: String?) {
        let name = LocalStorage.shared.keychain[KeyskKeychain._cookieName.rawValue]
        let value = LocalStorage.shared.keychain[KeyskKeychain._cookieValue.rawValue]
        return (name: name, value: value)
    }
}

enum KeyskKeychain: String {
    /// код тенанта
    case _codeTenant = "codeTenant"
    /// hostname
    case _hostname = "hostname"
    /// key for name
    case _cookieName = "name"
    /// key for value
    case _cookieValue = "value"
}

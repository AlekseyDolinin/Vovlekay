import WebKit
import KeychainAccess
import Foundation

class LocalStorage {
    
    static let shared = LocalStorage()
    
    var keychain = Keychain(service: "vovlekay")
    
    var _optionsTenant: JSON?
    var _languageDictionary: JSON?
    var _userData: JSON?
    var _currencies: [Currency]?
    
    class func saveValue(value: String, key: KeyskKeychain) {
        do {
            try LocalStorage.shared.keychain.set(value, key: key.rawValue)
        }
        catch let error {
            print(error)
        }
    }
    
    class func clearAllLocalStorage() {
        print("clearAllLocalStorage")
        LocalStorage.shared.clearKeychain()
        LocalStorage.shared.clearParameters()
        LocalStorage.shared.clearUserDefaults()
        LocalStorage.shared._userData = nil
    }
}


extension LocalStorage {
    
    // clear Keychain
    func clearKeychain() {
        print("clearKeychain")
        do {
            try LocalStorage.shared.keychain.remove(KeyskKeychain._codeTenant.rawValue)
            try LocalStorage.shared.keychain.remove(KeyskKeychain._hostname.rawValue)
            try LocalStorage.shared.keychain.remove(KeyskKeychain._cookieName.rawValue)
            try LocalStorage.shared.keychain.remove(KeyskKeychain._cookieValue.rawValue)
            print("Cookies in Keychain is clear")
        } catch let error {
            print("error remove keychain: \(error)")
        }
    }
    
    // clearParameters
    private func clearParameters() {
        print("clearParameters")
        LocalStorage.shared._optionsTenant = nil
        LocalStorage.shared._languageDictionary = nil
        LocalStorage.shared._userData = nil
    }
    
    // clearUserDefaults
    private func clearUserDefaults() {
        print("clearParameters")
        UserDefaults.standard.removeObject(forKey: "cookies")
    }
}

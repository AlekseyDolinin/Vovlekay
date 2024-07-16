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
        print("saveValue in keychain: \(value)")
        do {
            try LocalStorage.shared.keychain.set(value, key: key.rawValue)
            print("save in keychain succes")
        }
        catch let error {
            print(error)
        }
    }
    
    class func clearAllLocalStorage() {
        LocalStorage.shared.clearKeychain()
        LocalStorage.shared.clearParameters()
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
}

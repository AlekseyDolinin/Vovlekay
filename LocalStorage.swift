import WebKit
import KeychainAccess
import Foundation

class LocalStorage {

    static let keychain = Keychain(service: "vovlekay")
    
    
    class Parameters {
        static let shared = LocalStorage()
        
        static var optionsTenant: JSON?
        static let cookie = Keychain(service: "vovlekay")
    }
}




extension LocalStorage {
    
    class Cookies {

        class func saveCookie(webView: WKWebView) {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    if cookie.name == "user_id" && cookie.domain == Endpoint.hostname {
                        var cookieDict = [String : AnyObject]()
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                        guard let dictionary = cookieDict["user_id"] as? Dictionary<String, Any> else { return }
                        let name: String = dictionary["Name"] as! String
                        let value: String = dictionary["Value"] as! String
                        
                        do {
                            try LocalStorage.keychain.set(name, key: "name")
                            try keychain.set(value, key: "value")
                        }
                        catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
        
        // removeCookiesFromKeychain
        class func removeCookiesFromKeychain() {
            do {
                try LocalStorage.keychain.remove("name")
                try LocalStorage.keychain.remove("value")
                print("Cookies in Keychain is clear")
            } catch let error {
                print("error remove keychain: \(error)")
            }
        }
    }
}

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
                        // save cookies
//                        UserDefaults.standard.set(cookieDict, forKey: .cookiesKey)
//                        print(cookieDict[cookie.name])
//                        appDelegate.loadDataForStart()
                        
//                        if let cookie = cookieDict[cookie.name] {
//                            LocalStorage.saveCookies(cookie: cookie)
//                        }
                        print(cookieDict)
                        
                        guard let dictionary = cookieDict["user_id"] as? Dictionary<String, Any> else { return }
                        
                        print(dictionary["Name"])
                        print(dictionary["Value"])
                        
                        
                        let name: String = dictionary["Name"] as! String
                        let value: String = dictionary["Value"] as! String
                        
                        do {
                            try LocalStorage.keychain.set(name, key: "name")
                            try keychain.set(value, key: "value")
                        }
                        catch let error {
                            print(error)
                        }
                        
//                        guard let dictionary = savedCookie["user_id"] as? Dictionary<String, Any> else { return }
//                        guard let value: String = dictionary["Value"] as? String else { return }
//                        guard let name: String = dictionary["Name"] as? String else { return }
                        
//                        LocalStorage.saveCookies(cookie: cookieDict[cookie.name], key: "cookie_user_id")
                    }
                }
            }
        }

    }
    
//    class func saveCookies(cookie: Any?, key: String) {
//        
//        if cookie == nil { return }
//        
//        let cookieString: String = "\(cookie!)"
//        
//        do {
//            try keychain.set(cookieString, key: key)
//        }
//        catch let error {
//            print(error)
//        }
//        
//    }
}

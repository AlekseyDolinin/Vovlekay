import WebKit

class LocalStorage {

    class Parameters {
        static let shared = LocalStorage()
        
        static var optionsTenant: JSON?
    }
}




extension LocalStorage {
    
    class Cookies {

        class func saveCookie(webView: WKWebView) {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    print("cookie.domain: \(cookie.domain)")
                    print("Endpoint.hostname: \(Endpoint.hostname)")
                    print(cookie.name)
                    
                    if cookie.name == "user_id" && cookie.domain == Endpoint.hostname {
                        var cookieDict = [String : AnyObject]()
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                        // save cookies
//                        UserDefaults.standard.set(cookieDict, forKey: .cookiesKey)
//                        print("saveCookie")
//                        appDelegate.loadDataForStart()
                    }
                }
            }
        }

    }
}

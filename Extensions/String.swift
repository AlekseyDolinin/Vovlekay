import Foundation

public extension String {
//    static let tokenDeviceID = "tokenDeviceID"
//    static let fcmToken = "fcmToken"
//    static let hostname = "hostname"
//    static let cookiesKey = "cookiesKey"
//    static let languageCode = "languageCode"
//    static let idPreUser = "idPreUser"
//    static let codeTenant = "codeTenant"
    
    /// name service keychain storage
    static let _keychainName = "vovlekay"
    /// код тенанта
    static let _codeTenant = "codeTenant"
    /// hostname
    static let _hostname = "hostname"
    /// key for name
    static let _cookieName = "name"
    /// key for value
    static let _cookieValue = "value"
}


public extension String {
    
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl : String {
        return self.removingPercentEncoding!
    }
}

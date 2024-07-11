import Foundation

public extension String {
//    static let tokenDeviceID = "tokenDeviceID"
//    static let fcmToken = "fcmToken"
    static let hostname = "hostname"
//    static let cookiesKey = "cookiesKey"
//    static let languageCode = "languageCode"
//    static let idPreUser = "idPreUser"
    static let codeTenant = "codeTenant"
}


public extension String{
    
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl : String {
        return self.removingPercentEncoding!
    }
}

import Foundation

class Endpoint {
    
    static var hostname = ""
    
    private static var url_: String = { "https://" + hostname }()
    
    enum Endpoint {
        
        case sendTenantCode(code: String)
        case getOptionsTenant
        case linkAuth
        case getColorShemeTenant
        case getLanguageDictionary
        case getUserData
        
    }
    
    static func path(_ type: Endpoint) -> String {
        switch type {
            
        case .sendTenantCode(let code):
            if code.prefix(5) == "test-" {
                return ("http://auth-test.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            } else if code.prefix(4) == "pre-" {
                return ("http://auth-pre.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            } else {
                return ("http://auth.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            }
            
        case .getOptionsTenant:
            return url_ + "/api/options/"
            
        case .linkAuth:
            switch LocalStorage.Parameters.optionsTenant?["oauth2_custom"].string {
            case "t1":
                return "https://tinkoff.boxbattle.ru/"
            case "rg":
                return url_
            default:
                return url_
            }
            
        case .getColorShemeTenant:
            return url_ + "/game/api/v4/color_scheme/"
            
        case .getLanguageDictionary:
            return url_ + "/game/api/v6/get_language_dictionary/"
            
        case .getUserData:
            return url_ + "/api/get_user_data/"
            
            
            
            
            
            
            
        }
    }
}



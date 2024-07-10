import Foundation

class Endpoint {
    
    static var hostname = ""
    
    private static var url_: String = { "https://" + hostname }()
    
    enum Endpoint {
        
        case sendTenantCode(code: String)
        case getOptionsTenant
        case linkAuth
        
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
            
            
            
            
            
            
            
        }
    }
}



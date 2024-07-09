import Foundation

class Endpoint {
    
    static var hostname = ""
    
    private static var url_: String = { "https://" + hostname }()
    
    enum Endpoint {
                
        case sendTenantCode(code: String)
        case test
        
    }
    
    static func path(_ type: Endpoint) -> String {
        switch type {
            
        case .sendTenantCode(let code):
            if code.prefix(5).lowercased() == "test-" {
                return ("http://auth-test.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            } else if code.prefix(4) == "pre-" {
                return ("http://auth-pre.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            } else {
                return ("http://auth.boxbattle.ru/tenant-search/?code=\(code)").encodeUrl
            }
        case .test:
            return url_ + "ttttt"
        }
    }
}



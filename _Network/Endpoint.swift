import Foundation

public enum Endpoint {
    
    case sendTenantCode(code: String)
    
    public static func path(_ type: Endpoint) -> String {
        
        //        let url = Config.protocol_ + Config.hostname
        
        switch type {
            
        case .sendTenantCode(let code):
            return ("http://auth.boxbattle.ru/tenant-search/?code=\(code)")/*.encodeUrl*/
            
        }
    }
}

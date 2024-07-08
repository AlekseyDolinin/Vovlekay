import Foundation
import SwiftUI

class Servise {
    
    class func sendCodeTenant(codeTenant: String) {
//        showLoader()
        print(codeTenant)
//        Task(priority: .userInitiated) {
//            await sendTenantCode(codeTenant: inputeCode.text!.replacingOccurrences(of: " ", with: ""))
//        }
        
        let link = Endpoint.path(.sendTenantCode(code: codeTenant))
//        let json = await API.shared._request(link, needCookie: false)
        
        
        let json = API.getJSON(link: link)
    }
}




import SwiftUI

class CheckAuth {
    
    static let shared = CheckAuth()
    
    func check() -> Bool {
        print("CheckAuth")
        return false
    }
}

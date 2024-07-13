import Foundation
import SwiftUI

class AppLanguage {
        
    enum Language: String {
        case ru = "ru-RU"
        case en = "en-US"
        case kz = "kz-KZ"
    }
    
    static var language: Language = .ru
    
    static func changeLanguage(language: Language) -> Language {
        self.language = language
        return language
    }
}

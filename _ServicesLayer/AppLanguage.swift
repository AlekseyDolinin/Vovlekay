import Foundation
import SwiftUI

class AppLanguage {
    
    enum Language {
        case ru
        case en
        case kz
    }

    private static var language: Language = .ru
    
    static func changeLanguage(language: Language) -> Language {
        self.language = language
        return language
    }
}

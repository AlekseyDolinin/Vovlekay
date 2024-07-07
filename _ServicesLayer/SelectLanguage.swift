import Foundation
import SwiftUI

class SelectLanguage {
    
    private static var language: Language = .ru
    
    static func changeLanguage(language: Language) -> Language {
        self.language = language
        return language
    }
}

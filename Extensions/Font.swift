import SwiftUI

extension Font {
    
    public static func custom_(_ name: AppFont, size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
    
    public enum AppFont: String {
        case monospace = "Monospace"
        case rootUI_Regular = "PTRootUI-Regular"
        case rootUI_Medium = "PTRootUI-Medium"
        case rootUI_Bold = "PTRootUI-Bold"
    }
}

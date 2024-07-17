import UIKit
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

public extension UIColor {
    
//    class func hexStringToUIColor (hex: String) -> Color {
//        
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//
//        if ((cString.count) != 6) {
//            return Color.gray
//        }
//
//        var rgbValue:UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
//    
    var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}


public extension Color {
    
    static var BB_BGPrimary: Color!
//    static var BB_BGSecondary = UIColor()
//    static var BB_BGTertiary = UIColor()
//
    static var BB_PrimaryUI = Color(#colorLiteral(red: 0.9607843137, green: 0.9058823529, blue: 0.431372549, alpha: 1))
//    static var BB_SecondaryUI = UIColor()
//    
    static var BB_TextUI: Color!
//    static var BB_TextOnPrimary = UIColor()
    static var BB_RedUI: Color!
//    static var BB_GreenUI = UIColor()
//    static var BB_WarningUI = UIColor()
//    
//    static var BB_SPPrimary = UIColor()
//    static var BB_SPSecondary = UIColor()
//    static var BB_SPWhite = UIColor()
//    
//    static var Surface_BB_00db = UIColor()
//    static var Surface_BB_01db = UIColor()
//    static var Surface_BB_02db = UIColor()
//    static var Surface_BB_03db = UIColor()
//    
//    static var DEL_PrimaryBRAND = UIColor()
//
//    static var DEL_SecondaryBRAND = UIColor()
//
//    static var BB_TextPrimary = UIColor()
//    static var BB_TextSecondary = UIColor()
    static var BB_TextHigh: Color!
//    static var BB_TextMedium = UIColor()
//    static var BB_TextDisabled = UIColor()
//    static var BB_TextOnPrimaryHigh = UIColor()
//    static var BB_TextOnPrimaryMedium = UIColor()
//    static var BB_TextOnPrimaryDisabled = UIColor()
//
//    static var BB_SPOutline1 = UIColor()
//    static var BB_SPOutline2 = UIColor()
}

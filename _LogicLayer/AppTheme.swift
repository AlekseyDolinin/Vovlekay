import UIKit
import SwiftUI

public class AppTheme {
    
    public static var colors: JSON!
    public static var basicTheme: String = "dark"
    public static var customAuthLogoLink: String?  // в кнопке кастомной авторизации
    public static var logoMenuImage: UIImage?
    
//    //
//    public static func bgModal() -> UIColor {
//        return basicTheme == "dark" ? UIColor.hexStringToUIColor(hex: "232323") : UIColor.BB_BGTertiary
//    }
    
    //
    public static func createTheme(json: JSON) {
        print("createTheme")
        AppTheme.customAuthLogoLink = json["custom_auth_logo"].stringValue
        AppTheme.colors = json["colors"]
        AppTheme.basicTheme = json["basic_theme"].stringValue
        // basic
//        UIColor.BB_BGPrimary = UIColor.hexStringToUIColor(hex: colors["BGPrimary"].stringValue)
        Color.BB_PrimaryUI = Color.init(hex: colors["TextUI2"].stringValue)

//        UIColor.BB_SecondaryUI = UIColor.hexStringToUIColor(hex: colors["TextUI1"].stringValue)
//        UIColor.BB_TextUI = UIColor.hexStringToUIColor(hex: colors["TextPrimary"].stringValue)
//        UIColor.BB_TextOnPrimary = UIColor.hexStringToUIColor(hex: colors["TextUIButtonChange"].stringValue)
        
        Color.BB_RedUI = Color.init(hex: colors["FixedUIRed"].stringValue)
        
//        UIColor.BB_GreenUI = UIColor.hexStringToUIColor(hex: colors["FixedUIGreen"].stringValue)
//        UIColor.BB_WarningUI = UIColor.hexStringToUIColor(hex: colors["Warning"].stringValue)
        // other
//        UIColor.BB_BGSecondary = AppTheme.createBGSecondary()
//        UIColor.BB_BGTertiary = AppTheme.createBGTertiary()
        //
//        UIColor.BB_SPPrimary = AppTheme.createSPPrimary()
//        UIColor.BB_SPSecondary = AppTheme.createSPSecondary()
//        UIColor.BB_SPWhite = AppTheme.createSPWhite()
        // Surface
//        UIColor.Surface_BB_00db = AppTheme.createSurface_BB_00db()
//        UIColor.Surface_BB_01db = AppTheme.createSurface_BB_01db()
//        UIColor.Surface_BB_02db = AppTheme.createSurface_BB_02db()
//        UIColor.Surface_BB_03db = AppTheme.createSurface_BB_03db()
        // Primary_brand
//        UIColor.DEL_PrimaryBRAND = AppTheme.createDEL_PrimaryBRAND()
        // Secondary_Brand
//        UIColor.DEL_SecondaryBRAND = AppTheme.createDEL_SecondaryBRAND()
        // Text_ui
//        UIColor.BB_TextPrimary = createBB_TextPrimary()
//        UIColor.BB_TextSecondary = createBB_TextSecondary()
//        UIColor.BB_TextHigh = createBB_TextHigh()
//        UIColor.BB_TextMedium = createBB_TextMedium()
//        UIColor.BB_TextDisabled = createBB_TextDisabled()
//        UIColor.BB_TextOnPrimaryHigh = createBB_TextOnPrimaryHigh()
//        UIColor.BB_TextOnPrimaryMedium = createBB_TextOnPrimaryMedium()
//        UIColor.BB_TextOnPrimaryDisabled = createBB_TextOnPrimaryDisabled()
        //
//        UIColor.BB_SPOutline1 = createBB_SPOutline1()
//        UIColor.BB_SPOutline2 = createBB_SPOutline2()
    }

    private class func createBGSecondary() -> Color {
        if AppTheme.basicTheme == "dark" {
            let uiColor = UIColor(Color.BB_BGPrimary)
            let newColor = UIColor(hue: uiColor.hsba.h, saturation: uiColor.hsba.s, brightness: uiColor.hsba.b + 0.1, alpha: 1.0)
            return Color(newColor)
        } else {
            let uiColor = UIColor(Color.BB_BGPrimary)
            let newColor = UIColor(hue: uiColor.hsba.h, saturation: uiColor.hsba.s, brightness: uiColor.hsba.b - 0.04, alpha: 1.0)
            return Color(newColor)
        }
    }
    
//    private class func createBGTertiary() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue:UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b - 0.06, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b - 0.06, alpha: 1.0)
//        }
//    }
    
    private class func createSPPrimary() -> UIColor {
        if AppTheme.basicTheme == "dark" {
            return .white.withAlphaComponent(0.12)
        } else {
            return .black.withAlphaComponent(0.12)
        }
    }
    
    private class func createSPSecondary() -> UIColor {
        if AppTheme.basicTheme == "dark" {
            return .white.withAlphaComponent(0.08)
        } else {
            return .black.withAlphaComponent(0.08)
        }
    }
    
    private class func createSPWhite() -> UIColor {
        if AppTheme.basicTheme == "dark" {
            return .white.withAlphaComponent(0.5)
        } else {
            return .black.withAlphaComponent(0.5)
        }
    }
    
//    private class func createSurface_BB_00db() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor.BB_BGTertiary
//        } else {
//            return UIColor.BB_BGTertiary
//        }
//    }
    
//    private class func createSurface_BB_01db() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b + 0.06, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b + 0.06, alpha: 1.0)
//        }
//    }
    
//    private class func createSurface_BB_02db() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b + 0.16, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b - 0.02, alpha: 1.0)
//        }
//    }
    
//    private class func createSurface_BB_03db() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b + 0.24, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGTertiary.hsba.h, saturation: UIColor.BB_BGTertiary.hsba.s, brightness: UIColor.BB_BGTertiary.hsba.b + 0.24, alpha: 1.0)
//        }
//    }
    
//    private class func createDEL_PrimaryBRAND() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_PrimaryUI
//        } else {
//            return .BB_PrimaryUI
//        }
//    }
    
//    private static func createDEL_SecondaryBRAND() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_SecondaryUI
//        } else {
//            return .BB_SecondaryUI
//        }
//    }
    
//    private class func createBB_TextPrimary() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_PrimaryUI
//        } else {
//            return .BB_PrimaryUI
//        }
//    }
    
//    private class func createBB_TextSecondary() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_SecondaryUI
//        } else {
//            return .BB_SecondaryUI
//        }
//    }
    
//    private static func createBB_TextHigh() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextUI
//        } else {
//            return .BB_TextUI
//        }
//    }
//    
//    private class func createBB_TextMedium() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextUI.withAlphaComponent(0.7)
//        } else {
//            return .BB_TextUI.withAlphaComponent(0.7)
//        }
//    }
//    
//    private class func createBB_TextDisabled() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextUI.withAlphaComponent(0.5)
//        } else {
//            return .BB_TextUI.withAlphaComponent(0.5)
//        }
//    }
//    
//    private class func createBB_TextOnPrimaryHigh() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextOnPrimary.withAlphaComponent(0.9)
//        } else {
//            return .BB_TextOnPrimary.withAlphaComponent(0.9)
//        }
//    }
//    
//    private class func createBB_TextOnPrimaryMedium() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextOnPrimary.withAlphaComponent(0.7)
//        } else {
//            return .BB_TextOnPrimary.withAlphaComponent(0.7)
//        }
//    }
//    
//    private class func createBB_TextOnPrimaryDisabled() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return .BB_TextOnPrimary.withAlphaComponent(0.5)
//        } else {
//            return .BB_TextOnPrimary.withAlphaComponent(0.5)
//        }
//    }
//    
//    private class func createBB_SPOutline1() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue: UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b + 0.3, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b - 0.2, alpha: 1.0)
//        }
//    }
//    
//    private class func createBB_SPOutline2() -> UIColor {
//        if AppTheme.basicTheme == "dark" {
//            return UIColor(hue: UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b + 0.3, alpha: 1.0)
//        } else {
//            return UIColor(hue: UIColor.BB_BGPrimary.hsba.h, saturation: UIColor.BB_BGPrimary.hsba.s, brightness: UIColor.BB_BGPrimary.hsba.b - 0.4, alpha: 1.0)
//        }
//    }
}

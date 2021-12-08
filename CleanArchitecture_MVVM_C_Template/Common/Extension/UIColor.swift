//
//  UIColor.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

extension UIColor {
    
    public static func whiteTwo()->UIColor{
        return UIColor.appColor(.whiteTwo)
    }
    public static func whiteThree()->UIColor{
        return UIColor.appColor(.whiteThree)
    }
    
    
    
    public static func orangeyRed()->UIColor{
        return UIColor.appColor(.orangeyRed)
    }
    public static func blush()->UIColor{
        return UIColor.appColor(.blush)
    }
    public static func pale()->UIColor{
        return UIColor.appColor(.pale)
    }
    public static func lightPeach()->UIColor{
        return UIColor.appColor(.lightPeach)
    }
    public static func lightSalmon()->UIColor{
        return UIColor.appColor(.lightSalmon)
    }
    public static func veryLightPink()->UIColor{
        return UIColor.appColor(.veryLightPink)
    }
    public static func veryLightPink2()->UIColor{
        return UIColor.appColor(.veryLightPink2)
    }
    public static func veryLightPinkTwo()->UIColor{
        return UIColor.appColor(.veryLightPinkTwo)
    }
    
    
    
    public static func blueyGrey()->UIColor{
        return UIColor.appColor(.blueyGrey)
    }
    public static func greyishBrown()->UIColor{
        return UIColor.appColor(.greyishBrown)
    }
    public static func greyBrown()->UIColor{
        return UIColor.appColor(.greyBrown)
    }
    public static func black()->UIColor{
        return UIColor.appColor(.black)
    }
    public static func transparant_70()->UIColor{
        return UIColor.appColor(.transparant_70)
    }
    public static func transparant_50()->UIColor{
        return UIColor.appColor(.transparant_50)
    }
    public static func greyBlue()->UIColor{
        return UIColor.appColor(.greyBlue)
    }
    
}




extension UIColor {
    private static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .whiteTwo:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .whiteThree:
            return #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
            
        case .greyBrown:
            return #colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6235294118, alpha: 1)
        case .greyBlue:
            return #colorLiteral(red: 0.3902397752, green: 0.4783177376, blue: 0.5333773494, alpha: 1)
        case .greyishBrown:
            return #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        case .blueyGrey:
            return #colorLiteral(red: 0.6, green: 0.6274509804, blue: 0.6745098039, alpha: 1)
            
        case .pale:
            return #colorLiteral(red: 0.9843137255, green: 0.8745098039, blue: 0.8549019608, alpha: 1)
        case .blush:
            return #colorLiteral(red: 0.9450980392, green: 0.5803921569, blue: 0.5137254902, alpha: 1)
        case .orangeyRed:
            return #colorLiteral(red: 0.9607843137, green: 0.3294117647, blue: 0.2156862745, alpha: 1)
        case .lightPeach:
            return #colorLiteral(red: 0.9647058824, green: 0.7490196078, blue: 0.7137254902, alpha: 1)
        case .lightSalmon:
            return #colorLiteral(red: 0.9521830678, green: 0.6682059765, blue: 0.6039443016, alpha: 1)
        case .veryLightPink:
            return #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        case .veryLightPink2:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        case .veryLightPinkTwo:
            return #colorLiteral(red: 0.9960784314, green: 0.9803921569, blue: 0.9764705882, alpha: 1)
            
        case .transparant_50:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        case .transparant_70:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        case .transparant_90:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9)
        case .black:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}


enum AssetsColor {
    
    case whiteTwo
    case whiteThree
    
    case greyBrown
    case greyBlue
    case greyishBrown
    case blueyGrey
    
    case pale
    case blush
    case orangeyRed
    case lightPeach
    case lightSalmon
    
    case veryLightPink
    case veryLightPink2
    case veryLightPinkTwo
    
    case transparant_50
    case transparant_70
    case transparant_90
    
    case black
}

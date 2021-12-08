//
//  UIFont.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit


extension UIFont {
    
    /// regular
    public static func regular12()->UIFont{ return UIFont.regular(size: 12) }
    public static func regular14()->UIFont{ return UIFont.regular(size: 14) }
    public static func regular17()->UIFont{ return UIFont.regular(size: 17) }
    public static func regular20()->UIFont{ return UIFont.regular(size: 20) }
    public static func regular26()->UIFont{ return UIFont.regular(size: 26) }
    public static func regular38()->UIFont{ return UIFont.regular(size: 38) }

    /// medium
    public static func medium14()->UIFont{ return UIFont.medium(size: 14) }
    public static func medium17()->UIFont{ return UIFont.medium(size: 17) }
    public static func medium19()->UIFont{ return UIFont.medium(size: 19) }
    public static func medium20()->UIFont{ return UIFont.medium(size: 20) }
    public static func medium22()->UIFont{ return UIFont.medium(size: 22) }
    public static func medium24()->UIFont{ return UIFont.medium(size: 24) }
    public static func medium26()->UIFont{ return UIFont.medium(size: 26) }
    public static func medium28()->UIFont{ return UIFont.medium(size: 28) }
    public static func medium32()->UIFont{ return UIFont.medium(size: 32) }

    /// bold
    public static func bold14()->UIFont{ return UIFont.bold(size: 14) }
    public static func bold20()->UIFont{ return UIFont.bold(size: 20) }
    public static func bold24()->UIFont{ return UIFont.bold(size: 24) }
    public static func bold26()->UIFont{ return UIFont.bold(size: 26) }
    public static func bold32()->UIFont{ return UIFont.bold(size: 32) }
    
    
}

extension UIFont{
    private static func regular(size: CGFloat)-> UIFont{
        return UIFont(name: "NotoSansKR-regular", size: size)!
    }
    private static func medium(size: CGFloat)-> UIFont{
        return UIFont(name: "NotoSansKR-medium", size: size)!
    }
    private static func bold(size: CGFloat)-> UIFont{
        return UIFont(name: "NotoSansKR-Bold", size: size)!
    }
}

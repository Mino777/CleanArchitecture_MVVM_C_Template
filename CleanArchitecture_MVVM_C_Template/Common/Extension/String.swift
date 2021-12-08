//
//  String.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: "")
    }
    
    func localized(with arg: CVarArg = [], comment: String = "") -> String {
        return String(format: comment.localized, arg)
    }
    
//  func localized(arg: String) -> String{
//    return String.init(format: self.localized, arg)
//  }
//  func localized(arg: Int) -> String{
//    return String.init(format: self.localized, String.init(arg))
//  }
//  func localized(args: Int...) -> String{
//    return String.init(format: self.localized, args)
//  }
    
    public static func attributedStringForTotalSleep(_ string: String) -> NSAttributedString {
        let attributedStringForTotalSleep = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont.bold24(),
            .foregroundColor: UIColor.black
        ])
        
        if string.count == 8 {
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 2, length: 2))
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 7, length: 1))
        }
        
        if string.count == 7 {
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 1, length: 2))
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 6, length: 1))
        }
        
        if string.count == 4 {
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 2, length: 2))
        }
        
        if string.count == 3 {
            attributedStringForTotalSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 1, length: 2))
        }
        
        
        return attributedStringForTotalSleep
    }
    
    public static func attributedStringForAverageSleep(_ string: String) -> NSAttributedString {
        let attributedStringForAverageSleep = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont.bold24(),
            .foregroundColor: UIColor.black
        ])
        if string.count == 8 {
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 2, length: 2))
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 7, length: 1))
        }
        
        if string.count == 7 {
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 1, length: 2))
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location:  6, length: 1))
        }
        
        if string.count == 4 {
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 2, length: 2))
        }
        
        if string.count == 3 {
            attributedStringForAverageSleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 1, length: 2))
        }
        
        return attributedStringForAverageSleep
    }
    
    public static func attributedStringForTodaySleep(_ string: String) -> NSAttributedString {
        let attributedStringForTodaySleep = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont.bold24(),
            .foregroundColor: UIColor.black
        ])
        
        if string.count == 3 {
            attributedStringForTodaySleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 2, length: 1))
        }
        
        if string.count == 2 {
            attributedStringForTodaySleep.addAttribute(.font, value: UIFont.bold14(), range: NSRange(location: 1, length: 1))
        }
        
        
        return attributedStringForTodaySleep
    }
  
    static var light: String {
        return "light"
    }
    
    static var sensor: String {
        return "sensor"
    }
}

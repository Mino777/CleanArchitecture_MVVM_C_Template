//
//  UITextField.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

extension UITextField{
    
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        localize()
    }
    
    private func localize(){
        
        text = text?.localized
        
        attributedPlaceholder =
            NSAttributedString(
                string: attributedPlaceholder!.string.localized,
                attributes: [
                    NSAttributedString.Key.foregroundColor
                        : UIColor.init(named: "veryLightPinkTwo")!
                ])
    }
    
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
    
}


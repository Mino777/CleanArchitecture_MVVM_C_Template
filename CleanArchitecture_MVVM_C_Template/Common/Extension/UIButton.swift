//
//  UIButton.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

extension UIButton{
    open override func awakeFromNib() {
        super.awakeFromNib()
        localize()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        localize()
    }
    
    
    private func localize(){
        guard let title = titleLabel?.text else {
            return
        }
        setTitle(title.localized, for: .normal)
    }
}


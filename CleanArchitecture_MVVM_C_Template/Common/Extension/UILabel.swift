//
//  UILabel.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

extension UILabel{
    open override func awakeFromNib() {
        super.awakeFromNib()
        text = self.text?.localized
    }
}

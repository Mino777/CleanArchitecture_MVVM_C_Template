//
//  UIView.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

extension UIView{
  
  func animate(alpha : CGFloat, delay: Double, duration: Double){
    guard self.alpha != alpha else{ return }
    
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
        self.alpha = alpha
    }, completion: nil)
  }
  
  func animate(visible : Bool, delay: Double, duration: Double ){
    guard alpha != (visible ? 1.0 : 0.0) else{ return }
    
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
        self.alpha = visible ? 1.0 : 0.0
    }, completion: nil)
  }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}


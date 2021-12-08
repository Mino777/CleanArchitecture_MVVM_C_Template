//
//  BaseUIDialogViewController.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

class BaseUIDialogViewController : BaseUIViewController{
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.transparant_70()
  }
}


class BaseUIDismissableDialogViewController : BaseUIDialogViewController{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      guard let touch = touches.first,
            let touchView = touch.view,
            let containerView = self.view.subviews.first,
            (touchView == self.view || touchView == containerView) else {
              super.touchesBegan(touches, with: event)
              return
      }
      
      dismiss(animateDismissPopup: true)
    }
      
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
     if gestureRecognizer is UITapGestureRecognizer { return false }
     return (gestureRecognizer is UIScreenEdgePanGestureRecognizer)
    }

    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }
    
}


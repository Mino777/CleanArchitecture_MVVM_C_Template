//
//  BaseUINavigationController.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

class BaseUINavigationController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .default
  }
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    viewControllerToPresent.modalPresentationStyle = .fullScreen
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    interactivePopGestureRecognizer?.isEnabled = true
    super.pushViewController(viewController, animated: animated)
  }
}


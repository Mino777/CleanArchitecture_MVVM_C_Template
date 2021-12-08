//
//  UIViewController.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

import Toast_Swift

extension UIViewController{
  
  
  // MARK: Popup
  func present(_ popupViewControllerToPresent: UIViewController, animated: Bool){
    addChild(popupViewControllerToPresent)
    popupViewControllerToPresent.view.frame = view.frame
    view.addSubview(popupViewControllerToPresent.view)
      
    popupViewControllerToPresent.view.animate(visible: !animated, delay: 0, duration: 0)
    
    popupViewControllerToPresent.didMove(toParent: self)
    
    popupViewControllerToPresent.view.animate(visible: true, delay: 0, duration: 0.2)
      
  }
  func dismiss(animateDismissPopup animated: Bool, completion: (() -> Void)? = nil){
    if animated {
        view.animate(visible: false, delay: 0, duration: 0.2)
    }
    
    self.view.removeFromSuperview()
    self.removeFromParent()
    self.didMove(toParent: nil)
    
    completion?()
  }
  public func present(_ navigationControllerToPresent: UINavigationController, animated: Bool){
    navigationControllerToPresent.navigationBar.isHidden = true
    navigationControllerToPresent.interactivePopGestureRecognizer?.isEnabled = true
    navigationControllerToPresent.modalPresentationStyle = .fullScreen
    present(navigationControllerToPresent, animated: animated, completion: nil)
  }

  
  
  
  // MARK: Indicator
  func showIndicator(autoClose: Bool = false){
    
    self.view.endEditing(true)
    
    dismissIndicator{}
      
    let activityIndicator = UIActivityIndicatorView.init(style: .large)

    activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    activityIndicator.backgroundColor = UIColor.black()
    activityIndicator.color = UIColor.blush()
    activityIndicator.clipsToBounds = true
    activityIndicator.alpha = 0.8

    view.addSubview(activityIndicator)
    
    activityIndicator.startAnimating()
    
    if autoClose {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(4000), execute: {
          self.dismissIndicator()
        })
    }
  }
    func dismissIndicator(completion: (()->Void)? = nil){
        
        DispatchQueue.main.async {
            self.view.subviews.forEach { view in
                
                if view is UIActivityIndicatorView, let indicatorView = view as? UIActivityIndicatorView {
                    
                    indicatorView.stopAnimating()
                    indicatorView.removeFromSuperview()
                    indicatorView.willMove(toWindow: nil)
                }
            }
        }
        
        
        completion?()
    }
  
  
  
  // MARK: Alert
  func showAlert(title: String, msg: String, yesTitle: String, noTitle: String? = nil, yesHandler: (() -> Void)? = nil, noHandler: (() -> Void)? = nil){
    
    let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
    
    let actionYes = UIAlertAction(title: yesTitle, style: .default, handler: { alertAction in yesHandler?() })
    alert.addAction(actionYes)
    
    
    if let noTitle = noTitle{
      let actionNo = UIAlertAction(title: noTitle, style: .destructive, handler: { alertAction in noHandler?() })
      alert.addAction(actionNo)
    }
    
    present(alert, animated: true, completion: nil)
    
  }
  func showAlertActionSheet(sourceView: UIView? = nil, title: String? = nil, msg: String? = nil, options: [(title: String, style: UIAlertAction.Style, completion: (() -> Void)?)]){
    
    let alertController = UIAlertController.init(title: title, message: msg, preferredStyle: .actionSheet)
    
    if options.count > 0 {
      options.forEach { option in
        alertController.addAction(UIAlertAction(title: option.title, style: option.style, handler: { alertAction in option.completion?() }))
      }
    }else{
      alertController.addAction(UIAlertAction(title: " ", style: .default))
    }
    
    
    
    alertController.view.tintColor = UIColor.greyishBrown()
    alertController.isSpringLoaded = true
    
    if let sourceView = sourceView, UIDevice.current.userInterfaceIdiom == .pad{ /// 디바이스 타입이 iPad일때
      alertController.popoverPresentationController?.sourceView = sourceView
      alertController.popoverPresentationController?.sourceRect = sourceView.bounds
      alertController.popoverPresentationController?.permittedArrowDirections = [.left, .right, .down, .up]
      
    }
    
    self.present(alertController, animated: true, completion: nil)
  }
}


//// MARK: BottomSheet
//extension UIViewController{
//  func showButtomSheet(){
//    let bottomSheetViewController = BottomSheetViewController()
//    bottomSheetViewController.view.frame = .init(x: 0, y: view.frame.maxY, width: view.frame.width, height: view.frame.height)
//    addChild(bottomSheetViewController)
//    bottomSheetViewController.didMove(toParent: self)
//    view.addSubview(bottomSheetViewController.view)
//  }
//
//  public class BottomSheetViewController: UIViewController{
//    private enum State{
//      case partial
//      case full
//    }
//    private enum Constants{
//      static let fullViewYPosition: CGFloat = 100
//      static var partialViewYPosition: CGFloat { UIScreen.main.bounds.height - 130 }
//    }
//
//    public override func viewDidLoad() {
//      super.viewDidLoad()
//
//      print("viewDidLoad")
//
//      view.layer.cornerRadius = 10
//      view.clipsToBounds = true
//      view.backgroundColor = .lightGray
//    }
//
//    public override func viewWillAppear(_ animated: Bool) {
//      super.viewWillAppear(animated)
//      print("viewWillAppear")
//      UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
//        self.moveView(state: .partial)
//      }, completion: { flag in
//        self.view.rx.panGesture().subscribe(onNext: { [weak self] recognizer in
//          guard let self = self else{ return }
//          let translation = recognizer.translation(in: self.view)
//          let minY = self.view.frame.minY
//
//          if(minY + translation.y >= Constants.fullViewYPosition) &&
//            (minY + translation.y <= Constants.partialViewYPosition){
//            self.view.frame = .init(x: 0, y: minY + translation.y, width: self.view.frame.width, height: self.view.frame.height)
//            recognizer.setTranslation(.zero, in: self.view)
//          }
//
//
//          guard recognizer.state != .ended else { return }
//        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction], animations: {
//          let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial : .full
//          self.moveView(state: state)
//        }, completion: nil)
//        })
//      })
//
//    }
//
//    private func moveView(state: State){
//      let yPosition = state == .partial ? Constants.partialViewYPosition : Constants.fullViewYPosition
//      view.frame = .init(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
//    }
//  }
//}


extension UIViewController{
  func showToast(_ message: String){
    makeAndShowToast(message)
  }
  
  func showToast(_ error: Error){
//    makeAndShowToast(error.asNsError().domain)
  }
  
  private func makeAndShowToast(_ message: String){
    ToastManager.shared.isQueueEnabled = false
    ToastManager.shared.isTapToDismissEnabled = true
    ToastManager.shared.position = .bottom

    var style = ToastStyle.init()
    style.displayShadow = true
    style.shadowOffset = CGSize.init(width: 1, height: 1)
    style.shadowRadius = 3
    style.shadowOpacity = 0.5
    style.cornerRadius = 8
    style.horizontalPadding = 40
    style.messageAlignment = .left
    style.backgroundColor = UIColor.transparant_70()
    style.messageColor = UIColor.whiteTwo()

    self.view.endEditing(true)
    self.view.makeToast(message, duration: 3.0, style: style)
  }
}

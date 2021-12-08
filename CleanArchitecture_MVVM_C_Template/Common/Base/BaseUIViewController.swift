//
//  BaseUIViewController.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation


import UIKit
import RxSwift

class BaseUIViewController: UIViewController{
    
    internal var baseDisposeBag = DisposeBag() ///  viewWillDeisappear (only)
    internal var deinitDisposeBag = DisposeBag() /// deinit (only)
    
    internal var isStatusBarHidden = false
    internal var statusBarStyle: UIStatusBarStyle = .lightContent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.whiteTwo()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        setupViews()
        bindDeinitDisposable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindWillDisappearDisposable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        baseDisposeBag = DisposeBag()
    }
    
    deinit {
        deinitDisposeBag = DisposeBag()
    }
    
    internal func setupViews(){}
    internal func bindWillDisappearDisposable(){}
    internal func bindDeinitDisposable(){}
}

// MARK: Style
extension BaseUIViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return statusBarStyle }
    
    override var prefersStatusBarHidden: Bool { return isStatusBarHidden }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
}

// MARK: Present
extension BaseUIViewController{
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

// MARK: Gesture
extension BaseUIViewController : UIGestureRecognizerDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil { self.view.endEditing(true) }
        super.touchesBegan(touches, with: event)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer { return false }
        return (gestureRecognizer is UIScreenEdgePanGestureRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}



//
//  SplashViewController.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

import RxSwift

final class SplashViewController: BaseUIViewController, StoryboardInstantiable {
    private var viewModel: SplashViewModel!
    
    static func create(with viewModel: SplashViewModel) -> SplashViewController {
        let view = SplashViewController.instantiateViewController()
        view.viewModel = viewModel
        
        return view
    }
    
    override func viewDidLoad() {
        print("SPLASH")
    }
}

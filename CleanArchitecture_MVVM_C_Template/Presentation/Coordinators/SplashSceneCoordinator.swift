//
//  SplashSceneCoordinator.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

protocol SplashSceneCoordinatorDependency  {
    func createSplashViewController() -> SplashViewController
}

protocol SplashSceneCoordinatorDelegate  {
    func start(from navigationController: UINavigationController)
}

final class SplashSceneCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependency: SplashSceneCoordinatorDependency

    private weak var splashVC: SplashViewController?

    init(dependency: SplashSceneCoordinatorDependency) {
        self.dependency = dependency
    }
}

extension SplashSceneCoordinator: SplashSceneCoordinatorDelegate{
    func start(from navigationController: UINavigationController) {
        splashVC = dependency.createSplashViewController()
        
        self.navigationController = navigationController
        
        self.navigationController?.pushViewController(splashVC!, animated: false)
        print(#function)
    }

}

//
//  AppCoordinator.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private let appDIContainer: AppDIContainer
    
    public var splashSceneCoordinator: SplashSceneCoordinatorDelegate?
    
    private var splashNavigationController: UINavigationController?
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func startSplash(navigationController: UINavigationController) {
        
        splashNavigationController = navigationController
        
        splashSceneCoordinator =
            appDIContainer
            .createSplashSceneDIContainer()
            .createSplashCoordinator()
        
        splashSceneCoordinator?.start(from: navigationController)
        
        print(#function)
    }
}

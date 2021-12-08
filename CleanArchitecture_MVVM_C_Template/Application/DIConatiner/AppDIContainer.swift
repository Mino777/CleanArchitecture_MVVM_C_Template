//
//  AppDIContainer.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

final class AppDIContainer {
    
    lazy var templateAPIService = WebAPI<TemplateAPI>()
    
    lazy var templateStorage = TemplateStorage()
    
    func createSplashSceneDIContainer() -> SplashSceneDIContainer {
        SplashSceneDIContainer(
            dependencies: SplashSceneDIContainer.Dependencies(
                templateAPIService: templateAPIService,
                templateStorage: templateStorage
            )
        )
    }
}

//
//  SplashSceneDIContainer.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

final class SplashSceneDIContainer: SplashSceneCoordinatorDependency {
    
    struct Dependencies {
        let templateAPIService: WebAPI<TemplateAPI>
        let templateStorage: TemplateStorageDelegate
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    private func createTemplateRepository() -> TemplateRepositoryDelegate {
        TemplateRepository(service: dependencies.templateAPIService, storage: dependencies.templateStorage)
    }
    
    private func createTemplateUseCase() -> TemplateUseCaseDelegate {
        TemplateUseCase(repository: createTemplateRepository())
    }
    
    func createSplashViewController() -> SplashViewController {
        SplashViewController.create(with: SplashViewModel(templateUseCase: createTemplateUseCase()))
    }
    
    func createSplashCoordinator() -> SplashSceneCoordinator{
        SplashSceneCoordinator(dependency: self)
    }
}

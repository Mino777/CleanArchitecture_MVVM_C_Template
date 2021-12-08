//
//  TemplateUseCase.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

protocol TemplateUseCaseDelegate {
    
}

final class TemplateUseCase: TemplateUseCaseDelegate {
    private let repository: TemplateRepositoryDelegate
    
    init(repository: TemplateRepositoryDelegate) {
        self.repository = repository
    }
}

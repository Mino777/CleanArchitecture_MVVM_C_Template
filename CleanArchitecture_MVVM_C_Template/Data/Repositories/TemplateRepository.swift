//
//  TemplateRepository.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import RxSwift
import Moya

final class TemplateRepository {
    
    private let service: WebAPI<TemplateAPI>
    private let storage: TemplateStorageDelegate
    
    init(service: WebAPI<TemplateAPI>, storage: TemplateStorageDelegate){
        self.service = service
        self.storage = storage
    }
}

extension TemplateRepository: TemplateRepositoryDelegate {
    
}

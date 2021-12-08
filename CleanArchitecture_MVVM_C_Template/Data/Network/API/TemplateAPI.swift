//
//  TemplateAPI.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import Moya

enum TemplateAPI {
    case postTemplate(template: String)
}

extension TemplateAPI: TargetType {
    var baseURL: URL { try! "Template".asURL() }
    var path: String {
        switch self {
        case .postTemplate: return "Template"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postTemplate: return .post

        }
    }
    
    var headers: [String: String]? {
        switch self {
        
        default: return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .postTemplate(
                let template):
            return [
                "Template" : template
            ]
        default: return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default: return URLEncoding.default
        }
    }
    
    
    public var task: Task {
        switch self {
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
    var sampleData: Data { return Data() }
}

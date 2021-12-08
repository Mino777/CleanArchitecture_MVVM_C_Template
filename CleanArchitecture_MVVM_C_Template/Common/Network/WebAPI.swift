//
//  WebAPI.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import Moya
import RxSwift
import RealmSwift
import SwiftyJSON

class WebAPI<T> where T: Moya.TargetType {
    
    fileprivate let onlineObserver: Observable<Bool> = ReachabilityManager.shared.reach
    fileprivate let provider: MoyaProvider<T>
    
    init() {
        provider = MoyaProvider<T>(endpointClosure: { target in
            let endpoint = MoyaProvider<T>.defaultEndpointMapping(for: target)
            let accessToken = "Template"
            guard accessToken != "Template" else { return endpoint }
            return endpoint.adding(newHTTPHeaderFields: ["Cookie": accessToken])
            
        }, plugins: [APILoggingPlugin()])
    }
    
    func request(_ target: T) -> Single<Response> {
        let req = self.provider.rx.request(target)
        
        return req
            .flatMap({ response in
                
                print("- 응답 결과:", response, JSON(response.data))
                
                let statusCode = response.statusCode
                
                switch statusCode {
                case 500:
                    print("Template")
                default:
                    break
                }
                
                return Single.just(response)
            })
            .do(onSuccess: { response in
                print("==========================================================")
                print()
            }, onError: { error in
                print("- 요청 에러:", error)
            })
                }
}

final class APILoggingPlugin: PluginType {
    /// API를 보내기 직전에 호출
    func willSend(_ request: RequestType, target: TargetType) {
        
        guard let urlReq = request.request else { return }
        print()
        print("==========================================================")
        print("[ API 요청 ]")
        print("- 요청 url:", urlReq)
        
        guard let headers = urlReq.allHTTPHeaderFields else { return }
        print("- 요청 헤더:", headers)
        
        guard let body = urlReq.httpBody else { return }
        print("- 요청 바디:", JSON(body))
        
    }
    
    /// API Response
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        do {
            guard let res = try result.get().response else {
                print("응답 데이터 없음")
                return
            }
            
            guard let accessToken = res.allHeaderFields[AppConfigs.Network.setCookie] as? String else {
                print("쿠키 데이터 없음")
                return
            }
            
            Application.Data.accessToken = accessToken
            print("엑세스 토큰:", "Template")
            
        } catch {
            print("응답 에러: \(error)")
        }
        
    }
}

//
//  BaseViewModel.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import RxSwift

class BaseViewModel {
  let baseDispossBag = DisposeBag()
 
  func handleError(_ subject: PublishSubject<NSError>, _ error: Error,
                   _ funcName: String = #function, _ fileName: String = #file, _ lineNum: Int = #line){
//    subject.onNext(error.asNsError())
//    CrashlyticsHelper.send(error, funcName, fileName, lineNum)
  }
}


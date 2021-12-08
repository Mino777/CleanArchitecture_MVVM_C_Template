//
//  Reachability.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import Alamofire
import RxSwift


public final class ReachabilityManager: NSObject {

  static let shared = ReachabilityManager()
  var status = NetworkReachabilityManager.NetworkReachabilityStatus.unknown
  let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
  var reach: Observable<Bool> {
    return reachSubject.asObservable()
  }

  override init() {
    super.init()
    NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
      print("status: \(status)")

      self.status = status

      switch status {
      case .notReachable:
        print("ReachabilityManager: false")
        self.reachSubject.onNext(false)
      case .reachable(.ethernetOrWiFi):
        print("ReachabilityManager: reachable - ethernetOrWiFi")
        self.reachSubject.onNext(true)
      case .reachable(.cellular):
        print("ReachabilityManager: reachable - cellular")
        self.reachSubject.onNext(true)
      case .unknown:
        print("ReachabilityManager: unknown")
        self.reachSubject.onNext(false)
      }
    })
  }
}

// conn
extension ReachabilityManager{
  public func isWifiConn() -> Bool{
    return status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi)
  }

  public func isNetConn() -> Bool{
    return status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi)
        || status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.cellular)
  }
}


// observe conn
extension ReachabilityManager{

  public func observeWifiConn() -> Observable<Bool> {

    let subject = PublishSubject<Bool>().asObserver()
    
    NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
      print("status: \(status)")

      self.status = status

      switch status {
      case .reachable(.ethernetOrWiFi):
        subject.onNext(true)
      default:
        subject.onNext(false)
      }
         
    })
    
    return subject
  }

  public func observeNetConn() -> Observable<Bool> {

    let subject = PublishSubject<Bool>().asObserver()

    NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
      print("status: \(status)")

      self.status = status

      switch status {
      case .reachable( .ethernetOrWiFi), .reachable(.cellular):
        subject.onNext(true)
      default:
        subject.onNext(false)
      }

    })

    return subject
  }
}








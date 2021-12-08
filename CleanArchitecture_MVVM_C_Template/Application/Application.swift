//
//  Application.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit
import UserNotifications

import Kingfisher
import RxCocoa
import RxSwift

final class Application {
    static let shared = Application()
    private init(){}
    
    private let appDIContainer = AppDIContainer()
    public var appCoordinator: AppCoordinator?
    public var window: UIWindow?
    
    private let disposeBag = DisposeBag()
    
    func start(window: UIWindow?){
        
        self.window = window
        
        let navigationController = BaseUINavigationController()
        
        navigationController.navigationBar.isHidden = true
        
        self.window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(appDIContainer: appDIContainer)
        appCoordinator?.startSplash(navigationController: navigationController)
        
        self.window?.makeKeyAndVisible()
        
        print(#function)
    }
    
    func setUpLibs(appDelegate: AppDelegate, application: UIApplication){
        
        /// KingFisher SetUp
        ImageCache.default.diskStorage.config.sizeLimit = UInt(50 * 1024 * 1024)
        ImageCache.default.diskStorage.config.expiration = .days(7)
        ImageDownloader.default.downloadTimeout = 15.0
        
        
        /// Firebase SetUp
        //        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        //        let options = FirebaseOptions(contentsOfFile: filePath)!
        //        FirebaseApp.configure(options: options)
        //
        //        Messaging.messaging().delegate = appDelegate
        //
        //        if #available(iOS 10.0, *) {
        //            // For iOS 10 display notification (sent via APNS)
        //            UNUserNotificationCenter.current().delegate = appDelegate
        //
        //            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        //            UNUserNotificationCenter.current().requestAuthorization(
        //                options: authOptions,
        //                completionHandler: {_, _ in })
        //        } else {
        //            let settings: UIUserNotificationSettings =
        //                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        //            application.registerUserNotificationSettings(settings)
        //        }
        //
        //        application.registerForRemoteNotifications()
        
        /// Crashlytics Setup
        //        #if DEBUG
        //        Crashlytics.sharedInstance().debugMode = false
        //        #elseif RELEASE
        //        Crashlytics.sharedInstance().debugMode = true
        //        #endif
        
        
        // 네트워크 연결 확인
        ReachabilityManager.shared.observeNetConn().subscribe(onNext: { [weak self] isConn in
            
            guard let self = self, !isConn else { return }
            
            // 와이파이 연결 실패 Alert
            // 와이파이를 연결해주세요.
            UIApplication.topViewController()?.showAlert(
                title: "msg_check_wifi".localized,
                msg: "",
                yesTitle: "confirm".localized,
                yesHandler: { UIApplication.openSettingUrl() }
            )
            
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    private var willEnterForegroundDisposeBag = DisposeBag()
    
    @objc private func willEnterForeground(){
        
        willEnterForegroundDisposeBag = DisposeBag()
        // 네트워크 연결 확인
        ReachabilityManager.shared.observeNetConn().subscribe(onNext: { [weak self] isConn in
            
            guard let self = self, !isConn else { return }
            
            // 와이파이 연결 실패 Alert
            // 와이파이를 연결해주세요.
            UIApplication.topViewController()?.showAlert(
                title: "msg_check_wifi".localized,
                msg: "",
                yesTitle: "confirm".localized,
                yesHandler: { UIApplication.openSettingUrl() }
            )
            
        }).disposed(by: willEnterForegroundDisposeBag)
    }
    
}


// MARK: KingFisher
extension Application {
    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }
    
    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}


// MARK: UserDefaults Data
extension Application{
    public enum Data{
        public static let noneInt = -1
        public static let noneStr = ""
        public static let noneBool = false
                
        public static var accessToken: String{
            get{
                UserDefaults.getValue(defaultValue: noneStr, key: .accessToken)
            }
            set(val){
                UserDefaults.setValue(data: val, key: .accessToken)
            }
        }
        
        // MARK: Clear
        public static func clearOne(key: UserDefaults.Key){
            UserDefaults.clearOne(key: key)
        }
        public static func clearAll(){
            UserDefaults.clearAll()
        }
    }
}

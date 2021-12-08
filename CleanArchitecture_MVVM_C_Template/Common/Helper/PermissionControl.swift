//
//  PermissionControl.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit
import Photos

class PermissionControl {
    static let shared = PermissionControl()
    private init() {}
    
    open func requestPhotoAuthorization(from view: UIViewController, succeedAction: @escaping (() -> Void), failedAction: (() -> Void)? = nil) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if #available(iOS 14, *) {
                    if status == PHAuthorizationStatus.authorized || status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            succeedAction()
                        }
                    } else if let failedAction = failedAction {
                        DispatchQueue.main.async {
                            failedAction()
                        }
                    }
                } else {
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            succeedAction()
                        }
                    } else if let failedAction = failedAction {
                        DispatchQueue.main.async {
                            failedAction()
                        }
                    }
                }
            }
        case .denied: // 로컬라이징 필요
            let alert = UIAlertController(title: "사진 접근 권한이 필요합니다.",
                                          message: "사진을 업로드하기 위해 사진 접근 권한이 필요합니다",
                                          preferredStyle: .alert)
            let actionDone = UIAlertAction(title: "확인", style: .default) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            let actionCancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(actionDone)
            alert.addAction(actionCancel)
            view.present(alert, animated: true, completion: nil)
        case .restricted:
            view.showAlert(title: "사진에 접근할 수 없습니다", msg: "", yesTitle: "확인")
        case .authorized, .limited:
            PHPhotoLibrary.requestAuthorization { status in
                if #available(iOS 14, *) {
                    if status == PHAuthorizationStatus.authorized || status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            succeedAction()
                        }
                    } else if let failedAction = failedAction {
                        DispatchQueue.main.async {
                            failedAction()
                        }
                    }
                } else {
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            succeedAction()
                        }
                    } else if let failedAction = failedAction {
                        DispatchQueue.main.async {
                            failedAction()
                        }
                    }
                }
            }
        @unknown default:
            break
        }
    }
}


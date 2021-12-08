//
//  Reactive.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift
import RxGesture
import Kingfisher

extension Reactive where Base: UIImageView {

    public var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil)
    }

    public func imageURL(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo? = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url,
                                  placeholder: placeholderImage,
                                  options: options,
                                  progressBlock: nil,
                                  completionHandler: { (result) in })
        })
    }
}

extension ImageCache: ReactiveCompatible {}

extension Reactive where Base: ImageCache {

    func retrieveCacheSize() -> Observable<Int> {
        return Single.create { single in
            self.base.calculateDiskStorageSize { (result) in
                do {
                    single(.success(Int(try result.get())))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
        }.asObservable()
    }

    public func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create { }
        }.asObservable()
    }
}

extension Reactive where Base: UIView {
    func tap() -> Observable<UITapGestureRecognizer> {
        return tapGesture().when(.recognized).throttle(.milliseconds(500), scheduler: MainScheduler.instance)
    }
}

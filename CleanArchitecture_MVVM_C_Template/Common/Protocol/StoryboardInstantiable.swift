//
//  StoryboardInstantiable.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        guard let vc = UIStoryboard(name: defaultFileName, bundle: bundle).instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(defaultFileName)")
        }
        return vc
    }
}


public extension StoryboardInstantiable where Self: UITableViewCell {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
}

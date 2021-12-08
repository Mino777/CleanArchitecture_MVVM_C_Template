//
//  StoryboardIdentifiable.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//


import UIKit

public protocol StoryboardIdentifiable: NSObjectProtocol {
    static var identifier: String { get }
}


public extension StoryboardIdentifiable{
    static var identifier: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
}

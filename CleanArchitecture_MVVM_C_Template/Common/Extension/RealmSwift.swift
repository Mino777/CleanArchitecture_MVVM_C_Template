//
//  RealmSwift.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import RealmSwift

extension Results{
  func toArray() -> [Element]{
    return compactMap{ $0 }
  }
}

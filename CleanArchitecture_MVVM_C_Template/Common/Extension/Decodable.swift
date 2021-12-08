//
//  Decodable.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

extension KeyedDecodingContainer {
  func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
      return try decode(T.self, forKey: key)
  }
  func decodeArray<T>(_ key: KeyedDecodingContainer.Key) throws -> [T] where T: Decodable {
      return try decode([T].self, forKey: key)
  }
  
  func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
    return try decodeIfPresent(T.self, forKey: key)
  }

  subscript<T>(key: Key) -> T where T: Decodable {
      return try! decode(T.self, forKey: key)
  }
}

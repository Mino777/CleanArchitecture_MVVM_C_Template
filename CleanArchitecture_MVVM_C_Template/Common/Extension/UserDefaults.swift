//
//  UserDefaults.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

extension UserDefaults{
  
  public enum Key: String{
    case accessToken

  }
  
  public static func clearOne(key: Key){
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
  public static func clearAll(){
    for key in UserDefaults.standard.dictionaryRepresentation().keys {
      UserDefaults.standard.removeObject(forKey: key.description)
    }
  }
  
  
  // MARK: Set
  public static func setValue<T: Codable>(data: T, key: Key){
    do {
      try UserDefaults.standard.set(JSONEncoder.init().encode(data), forKey: key.rawValue)
    } catch{
      print("UserDefaults saving \(key) Error: \(error)")
    }
  }
  
  public static func setValue<T: Codable>(data: T, key: String){
    do {
      try UserDefaults.standard.set(JSONEncoder.init().encode(data), forKey: key)
    } catch{
      print("UserDefaults saving \(key) Error: \(error)")
    }
  }
  
  
  // MARK: Get
  public static func getValue<T: Codable>(defaultValue: T, key: Key) -> T{
    guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
      return defaultValue
    }
    
    do {
      return try JSONDecoder.init().decode(T.self, from: data)
    } catch {
      print("UserDefaults saving \(key) Error: \(error)")
    }
    
    return UserDefaults.standard.object(forKey: key.rawValue) as! T
  }
  
  public static func getValue<T: Codable>(defaultValue: T, key: String) -> T{
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return defaultValue
    }
    
    do {
      return try JSONDecoder.init().decode(T.self, from: data)
    } catch {
      print("UserDefaults saving \(key) Error: \(error)")
    }
    
    return UserDefaults.standard.object(forKey: key) as! T
  }
  
}

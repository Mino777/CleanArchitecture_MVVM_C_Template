//
//  RealmManager.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

import Realm
import RealmSwift
import RxSwift

final class RealmManager{
    
    public static let realm: Realm = {
        return try! Realm()
    }()

    
    // MARK: Write
    public static func write(onSuccess: (()->Void)? = nil, onFail: ((Error)->Void)? = nil){
        writeIn(onSuccess: {
            onSuccess?()
        }, onFail: { error in
            onFail?(error)
        })
    }
    private static func writeIn(onSuccess: @escaping ()->Void, onFail: @escaping (Error)->Void){
        guard !realm.isInWriteTransaction else {
            onSuccess ()
            return
        }
        
        do {
            try realm.write{
                onSuccess()
            }
        } catch {
            let error = error as NSError
            print("RealmManager Error: \(error.localizedDescription)")
            onFail(error)
        }
    }
    
    
    // MARK: Find
    public static func findOne<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType, onSuccess: ((Element)->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            onSuccess?(realm.object(ofType: type, forPrimaryKey: key) ?? Element.init())
        }, onFail: { error in
            onFail?(error)
        })
    }
    public static func findMany<Element: Object>(ofType type: Element.Type, hasElement: @escaping (Element) -> Bool, onSuccess: (([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            onSuccess?(realm.objects(type).toArray().filter{ hasElement($0) })
        }, onFail: { error in
            onFail?(error)
        })
    }
    //  public static func findMany<Element: Object, KeyType>(list: [Element], selectPk: @escaping (Element) -> KeyType, onSuccess: (([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
    //    write(onSuccess: {
    //
    //      var foundList = [Element]()
    //      for element in list {
    //        if let item = realm.object(ofType: Element.self, forPrimaryKey: selectPk(element)) {
    //          foundList.append(item)
    //        }
    //      }
    //      onSuccess?(foundList)
    //
    //    }, onFail: { error in
    //      onFail?(error)
    //    })
    //  }
    public static func findAll<Element: Object>(ofType type: Element.Type, onSuccess: (([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            onSuccess?(realm.objects(type).toArray())
        }, onFail: { error in
            onFail?(error)
        })
        
    }
    
    
    // MARK: Create
    public static func createOneOrUpdateOne<Element: Object>(element: Element, onSuccess: ((Element)->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            let saved = realm.create(Element.self, value: element, update: .modified)
            onSuccess?(saved)
            
            print("title22 create Success")
        }, onFail: { error in
            onFail?(error)
            print("title22 create Error")
        })
    }
    public static func createManyOrUpdateMany<Element: Object>(list: [Element], onSuccess: ( ([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            var createdList = [Element]()
            for element in list {
                createdList.append(realm.create(Element.self, value: element, update: .modified))
            }
            onSuccess?(createdList)
            
        }, onFail: { error in
            onFail?(error)
        })
    }
    
//    public static func onlyAdd<Element: Object>(list: [Element], onSuccess: ( ([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
//        writeIn(onSuccess: {
//
//            var createdList = [Element]()
//            for element in list {
//                createdList.append(element)
//
//            }
//            realm.add(createdList)
//            onSuccess?(createdList)
//
//        }, onFail: { error in
//            onFail?(error)
//        })
//    }
    
    public static func deleteOneAndCreateOne<Element: Object, KeyType>(element: Element, selectPk: @escaping (Element) -> KeyType, onSuccess: ((Element)->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            if let item = realm.object(ofType: Element.self, forPrimaryKey: selectPk(element)) {
                realm.delete(item)
            }
            let saved = realm.create(Element.self, value: element, update: .all)
            onSuccess?(saved)
            
        }, onFail: { error in
            onFail?(error)
        })
    }
    public static func deleteManyAndCreateMany<Element: Object, KeyType>(list: [Element], selectPk: @escaping (Element) -> KeyType, onSuccess: (([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            var createdList = [Element]()
            for element in list {
                if let item = realm.object(ofType: Element.self, forPrimaryKey: selectPk(element)) {
                    realm.delete(item)
                }
                createdList.append(realm.create(Element.self, value: element, update: .all))
            }
            
            onSuccess?(createdList)
            
        }, onFail: { error in
            onFail?(error)
        })
    }
    public static func deleteAllAndCreateMany<Element: Object>(list: [Element], onSuccess: (([Element])->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            let savedList = realm.objects(Element.self)
            for saved in savedList {
                realm.delete(saved)
            }
            
            var createdList = [Element]()
            for element in list {
                createdList.append(realm.create(Element.self, value: element, update: .all))
            }
            
            onSuccess?(createdList)
            
        }, onFail: { error in
            onFail?(error)
        })
    }
    
    
    
    // MARK: Delete
    public static func deleteOne<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType, onSuccess: (()->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            
            if let item = realm.object(ofType: type, forPrimaryKey: key) {
                realm.delete(item)
                onSuccess?()
            }else{
                onFail?(NSError.init(domain: "Nothing to delete", code: 0))
            }
            
        }, onFail: { error in
            onFail?(error)
        })
    }
    
    public static func deleteAll<Element: Object>(ofType type: Element.Type, completion: (()->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            realm.delete(realm.objects(type).toArray())
            completion?()
        }, onFail: { error in
            onFail?(error)
        })
    }
    
    
    // MARK: Clear
    public static func clearAll(completion: (()->Void)? = nil, onFail: ((Error) ->Void)? = nil){
        writeIn(onSuccess: {
            realm.deleteAll()
            completion?()
        }, onFail: { error in
            onFail?(error)
        })
    }
}


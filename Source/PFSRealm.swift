//
//  PFSRealm.swift
//  IBLNetAssistant
//
//  Created by 李智慧 on 16/07/2017.
//  Copyright © 2017 李智慧. All rights reserved.
//

import UIKit
import RealmSwift
import Result
import Moya


open class PFSRealm {
    
    public static var config: Realm.Configuration?

    public static var realm: Realm {
        get {
            guard let config = PFSRealm.config else {
                return try! Realm()
            }
            
            return try! Realm(configuration: config)
        }
    }
    
    public static let shared = PFSRealm()
    
    init() {
    }
    
    @discardableResult
    public func save<T: Object>(obj: T) -> Result<T, MoyaError> {
        do {
            try PFSRealm.realm.write { PFSRealm.realm.add(obj) }
        } catch let error {
            return Result(error: MoyaError.underlying(error, nil))
        }
        
        return Result(value: obj)
    }
    
    @discardableResult
    public func update<T: Object>(obj: T, _ handler: @escaping (T) -> Void) -> Result<T, MoyaError> {
        do {
            try PFSRealm.realm.write { handler(obj) }
        } catch let error {
            return Result(error: MoyaError.underlying(error, nil))
        }
        
        return Result(value: obj)
    }
    
    @discardableResult
    public func update<T: Object>(obj: T) -> Result<T, MoyaError> {
        do {
            try PFSRealm.realm.write { PFSRealm.realm.add(obj, update: true) }
        } catch let error {
            return Result(error: MoyaError.underlying(error, nil))
        }
        return Result(value: obj)
    }

    public func object<T: Object>() -> T? {
        return PFSRealm.realm.objects(T.self).first
    }
    
    public func object<T: Object>(forPrimaryKey: String) -> T? {
        return PFSRealm.realm.object(ofType: T.self, forPrimaryKey: forPrimaryKey)
    }
    
    public func object<T: Object>(_ predicateFormat: String, _ args: Any...) -> T? {
        let predicate = NSPredicate(format: predicateFormat, argumentArray: args)
        return PFSRealm.realm.objects(T.self).filter(predicate).first
    }
    
    @discardableResult
    public func save<T: Object>(objs: [T]) -> Result<[T], MoyaError> {
        do {
            try PFSRealm.realm.write { PFSRealm.realm.add(objs) }
        } catch let error {
            return Result(error: MoyaError.underlying(error, nil))
        }
        
        return Result(value: objs)
    }
    
    public func clean() throws{
        try PFSRealm.realm.write { PFSRealm.realm.deleteAll() }
       
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
//        let realmURLs = [
//            realmURL,
//            realmURL.appendingPathExtension("lock"),
//            realmURL.appendingPathExtension("note"),
//            realmURL.appendingPathExtension("management")
//        ]
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL)
//            } catch {
//                throw error
//            }
//        }
    }
    
    public func deleteAll<T: Object>(typeOf obj: T.Type) throws  {
        try PFSRealm.realm.write { PFSRealm.realm.delete(PFSRealm.realm.objects(obj)) }
    }
    
}

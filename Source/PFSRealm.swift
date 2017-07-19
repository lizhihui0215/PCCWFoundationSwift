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

    private var realm: Realm {
        get {
            return try! Realm()
        }
    }
    
    public static let shared = PFSRealm()
    
    init() {
    }
    
    public func save<T: Object>(obj: T) -> Result<T, MoyaError> {
        do {
            try realm.write { realm.add(obj) }
        } catch let error {
            return Result(error: MoyaError.underlying(error))
        }
        
        return Result(value: obj)
    }
    
    public func update<T: Object>(obj: T, _ handler: @escaping (T) -> Void) -> Result<T, MoyaError> {
        do {
            try realm.write { handler(obj) }
        } catch let error {
            return Result(error: MoyaError.underlying(error))
        }
        
        return Result(value: obj)
    }

    public func object<T: Object>() -> T? {
        return realm.objects(T.self).first
    }
    
    public func object<T: Object, K>(_ forPrimaryKey: K) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: forPrimaryKey)
    }
}

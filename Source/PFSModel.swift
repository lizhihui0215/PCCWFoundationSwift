//
//  PFSModel.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 21/04/2017.
//
//

import RealmSwift
import ObjectMapper

open class PFSModel: Object, Mappable {
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        
    }
}

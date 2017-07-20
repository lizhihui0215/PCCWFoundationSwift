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

    dynamic public var uuid: String = UUID().uuidString

    public required convenience  init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
       
    }
    
    override open static func primaryKey() -> String? {
        return "uuid"
    }

}

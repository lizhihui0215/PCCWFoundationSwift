//
//  PFSModel.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 21/04/2017.
//
//

import RealmSwift
import ObjectMapper

open class PFSModel: Object, Mappable, NSCoding {

    dynamic public var uuid: String?

    public required convenience  init?(map: Map) {
        self.init()
        
        if let uuid = map.JSON["uuid"]  {
            self.uuid = uuid as? String
        }else {
            self.uuid = UUID().uuidString
        }  
    }
    
    open func mapping(map: Map) {
        
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: "uuid")
    }
    
    override open static func primaryKey() -> String? {
        return "uuid"
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as? String
    }

}

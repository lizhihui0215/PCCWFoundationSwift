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

    dynamic var uuid = UUID().uuidString

    public convenience required init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        
    }

    public func encode(with aCoder: NSCoder) {
    }

    public required init?(coder aDecoder: NSCoder) {
        self.init()
    }

}

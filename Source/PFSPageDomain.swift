//
//  PFSPageDomain.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 01/06/2017.
//
//

import Foundation

open class PFSPageDomain: PFSDomain {
    public var page: Int = 0
    
    public var size: Int = 20
    
    public func start(refresh: Bool)  {
        if refresh { page = 0 } else { page += 1 }
    }
    
    public func error()  {
        page -= 1
        if page < 0 { page = 0}
    }
    
    
}

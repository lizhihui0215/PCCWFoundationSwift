//
//  String+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 31/05/2017.
//
//

import Foundation
public extension Optional where Wrapped == String {
    public var orEmpty: String {
        return self ?? ""
    }
    
    
}

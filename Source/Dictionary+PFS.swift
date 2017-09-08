//
//  Dictionary+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 08/09/2017.
//
//

import Foundation

public func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

//
//  PFSDebug.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 17/07/2017.
//
//

import UIKit

public func debug<T>(_ identifier: String? = "", file: String = #file, model: T, line: UInt = #line, function: String = #function, content: String? = "") {
    var content = content
    
    let formatter = DateFormatter()
    
    formatter.dateFormat = dateFormat
    if (content?.count)! > 0 {
        content = "- \(String(describing: content))"
    }
    
    print("\(formatter.string(from: Date())) \(String(describing: identifier)) \(file) \(String(describing: T.self)).\(function):\(line) \(String(describing: content))")
}

fileprivate let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

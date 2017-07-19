//
//  PFSTools.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 31/05/2017.
//
//

import Foundation

class PFSTools {
    
}

public func swizzling(target: AnyClass,originalSelector : Selector, swizzledSelector: Selector)  {
    let originalMethod = class_getInstanceMethod(target, originalSelector)
    let swizzledMethod = class_getInstanceMethod(target, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

public func basicType<N>(_ field: N) -> Bool {
    if let x = field as Any? , false
        || x is NSNumber // Basic types
        || x is Bool
        || x is Int
        || x is Double
        || x is Float
        || x is String
        || x is NSNull
        || x is Array<NSNumber> // Arrays
        || x is Array<Bool>
        || x is Array<Int>
        || x is Array<Double>
        || x is Array<Float>
        || x is Array<String>
        || x is Array<Any>
        || x is Array<Dictionary<String, Any>>
        || x is Dictionary<String, NSNumber> // Dictionaries
        || x is Dictionary<String, Bool>
        || x is Dictionary<String, Int>
        || x is Dictionary<String, Double>
        || x is Dictionary<String, Float>
        || x is Dictionary<String, String>
        || x is Dictionary<String, Any>
    {
        return true
    }
    
    return false
}

public func optionalBasicType<N>(_ field: N?) -> Bool {
    if let field = field {
        return basicType(field)
    }
    
    return false
}

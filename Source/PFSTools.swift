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
        || x is NSNumber.Type // Basic types
        || x is Bool.Type
        || x is Int.Type
        || x is Double.Type
        || x is Float.Type
        || x is String.Type
        || x is NSNull.Type
        || x is Array<NSNumber>.Type // Arrays
        || x is Array<Bool>.Type
        || x is Array<Int>.Type
        || x is Array<Double>.Type
        || x is Array<Float>.Type
        || x is Array<String>.Type
        || x is Array<Any>.Type
        || x is Array<Dictionary<String, Any>>.Type
        || x is Dictionary<String, NSNumber>.Type// Dictionaries
        || x is Dictionary<String, Bool>.Type
        || x is Dictionary<String, Int>.Type
        || x is Dictionary<String, Double>.Type
        || x is Dictionary<String, Float>.Type
        || x is Dictionary<String, String>.Type
        || x is Dictionary<String, Any>.Type
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

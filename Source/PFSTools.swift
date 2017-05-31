//
//  PFSTools.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 31/05/2017.
//
//

import Foundation

public func swizzling(target: AnyClass,originalSelector : Selector, swizzledSelector: Selector)  {
    let originalMethod = class_getInstanceMethod(target, originalSelector)
    let swizzledMethod = class_getInstanceMethod(target, swizzledSelector)

    method_exchangeImplementations(originalMethod, swizzledMethod)
}

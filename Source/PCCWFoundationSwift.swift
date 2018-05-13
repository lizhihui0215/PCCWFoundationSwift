//
//  PCCWFoundationSwift.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 19/04/2017.
//
//

import Foundation
import IQKeyboardManagerSwift

private let token = "com.pccw.foundation.swift.setup.swizzling.token"

public func setup()  {
    DispatchQueue.once(token: token) { 
        swizzling(target: UIViewController.self,
                  originalSelector:#selector(UIViewController.viewDidLoad),
                  swizzledSelector: #selector(UIViewController.pfs_viewDidLoad))
        IQKeyboardManager.shared.enable = true
    }
}

//
//  PCCWFoundationSwift.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 19/04/2017.
//
//

import Foundation

public func setup()  {
    swizzling(target: UIViewController.self,
              originalSelector:#selector(UIViewController.viewDidLoad),
              swizzledSelector: #selector(UIViewController.pfs_viewDidLoad))
}

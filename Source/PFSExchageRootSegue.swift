//
//  PFSExchageRootSegue.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 05/06/2017.
//
//

import UIKit

class PFSExchageRootSegue: UIStoryboardSegue {
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination);
    }
    
    override func perform() {
         UIApplication.shared.delegate?.window??.rootViewController = self.destination
    }
}

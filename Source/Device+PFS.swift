//
//  Device+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 21/04/2017.
//
//

import DeviceKit
import KeychainAccess

let keychain = Keychain()

let device = Device()

extension Device {
    public var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public var appName: String{
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    }
    
    public var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    public var uuid: String {
        
        if let uuid = keychain["uuid"] {
            return uuid
        }
        
        let uuid = UUID().uuidString
        
        keychain["uuid"] = uuid
        
        return uuid
    }
}

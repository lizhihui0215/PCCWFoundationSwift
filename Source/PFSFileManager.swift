//
//  PFSFileManager.swift
//  IBLNetAssistant
//
//  Created by 李智慧 on 16/07/2017.
//  Copyright © 2017 李智慧. All rights reserved.
//

import UIKit

open class PFSFileManager {
    public static let shared = PFSFileManager()
    
    public var home: String
    
    public var document: String
    
    init() {
        home = NSHomeDirectory()
        document =  NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask,
                                                        true)[0]
    }
}

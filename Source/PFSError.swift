//
//  PFSError.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 01/06/2017.
//
//

import Moya
import Result

public func error(message: String, code: String? = "0") -> MoyaError {
    return MoyaError.underlying(Result<String, MoyaError>.error(message, code: code))
}


extension Result {
    public static func error(_ message: String? = nil, code: String?, function: String = #function, file: String = #file, line: Int = #line) -> NSError {

        var userInfo: [String: Any] = [
            functionKey: function,
            fileKey: file,
            lineKey: line,
            ]
        
        if let message = message {
            userInfo[NSLocalizedDescriptionKey] = message
        }
        
        var errorCode = 0
        
        if let code = code {
            errorCode = Int(code)!
        }
        
        return NSError(domain: errorDomain, code: errorCode, userInfo: userInfo)

    }
}

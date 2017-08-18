//
//  PFSError.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 01/06/2017.
//
//

import Moya
import Result

public func error(message: String, code: String? = "0", userInfo: [String: Any] = [:]) -> MoyaError {
    return MoyaError.underlying(Result<String, MoyaError>.error(message, code: code, userInfo: userInfo))
}

public var PFSServerErrorDomain: String { return "com.pccw.foundation.swift.server.response.error" }


extension Result {
    public static func error(_ message: String? = nil, code: String?, userInfo: [String: Any] = [:], function: String = #function, file: String = #file, line: Int = #line) -> NSError {

        var userInfo = userInfo
        userInfo[functionKey] = function
        userInfo[fileKey] = file
        userInfo[lineKey] = line
                
        if let message = message {
            userInfo[NSLocalizedDescriptionKey] = message
        }
        
        var errorCode = 0
        
        if let code = code {
            errorCode = Int(code)!
        }
        
        return NSError(domain: PFSServerErrorDomain, code: errorCode, userInfo: userInfo)

    }
}

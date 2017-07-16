//
//  PFSError.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 01/06/2017.
//
//

import Moya
import Result

public func error(message: String) -> MoyaError {
    return MoyaError.underlying(Result<String, MoyaError>.error(message))
}

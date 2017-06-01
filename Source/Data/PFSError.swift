//
//  PFSError.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 01/06/2017.
//
//

import Moya

public enum PFSError: Swift.Error{
    init(code: Int, message: String) {
        self = .serverError(code, message)
    }
    case serverError(Int, String)
}

extension PFSError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .serverError(_, message):
            return message
        }
    }
}

extension PFSError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .serverError(code, message):
            return "error code is {\(code)}\n message is\(message)"
        }
    }
}

func error(code: Int = 0, message: String?) -> MoyaError {
    return MoyaError.underlying(PFSError(code: code , message: message ?? "unknow"))
}

//
// Created by 李智慧 on 09/05/2017.
//

import Foundation
import RxCocoa
import Result
import RxSwift
import Moya

public protocol PFSViewAction: class {
    func alert<T>(result: Result<T, MoyaError>) -> Driver<Result<T, MoyaError>>
    
    func alert(message: String) -> Driver<Bool>
    
    func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void)
}

extension PFSViewAction {
    public func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void){
        
    }
}

public class PFSValidate<T> {

    private var result: Result<T?, MoyaError> = Result(value: nil)

    public init(content: T?) {
        self.result = Result(value: content)
    }
    
    public func notNull(message: String) -> Self{


        
//        guard let content = self.content, status else {
//            return self
//        }
//        
//        if !(content.characters.count > 0) {
//            status = false
//            self.message = message
//        }
        
        return self
    }
    
    public func max(length: Int, message: String) -> Self {
//        guard let content = self.content, status else {
//            return self
//        }
//        
//        if content.characters.count > length {
//            status = false
//            self.message = message
//        }
        return self
    }
    
    public func min(length: Int, message: String) -> Self {
//        guard let content = self.content, status else {
//            return self
//        }
//        
//        if content.characters.count < length {
//            status = false
//            self.message = message
//        }
        return self
    }

//    public func validate() -> Result<T?, MoyaError> {
//        if status { return Result(value: Void) }
//
//        return Result(error: error(message: self.message))
//    }
    
//    public class func validate(validates: [PFSValidate]) -> Result<[PFSValidate], MoyaError> {
//        var result = Result<[PFSValidate], MoyaError>(value: validates)
//        for validate in validates {
//            validate.validate().debugDescription
//        }
//        return result
//    }
}

open class PFSViewModel<T: PFSViewAction, D: PFSDomain> {
    public weak var action: T?
    
    public var domain: D
    
    public let disposeBag = DisposeBag()

    public init(action: T, domain: D) {
        self.action = action
        self.domain = domain
    }
}

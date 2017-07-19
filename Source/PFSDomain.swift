//
// Created by 李智慧 on 09/05/2017.
//

import Foundation
import Moya
import RxSwift
import Result
import RxCocoa

open class PFSDomain {
    
    public init() {
        
    }
    
    public func toDriver<T>(ob: Observable<Result<T, Moya.MoyaError>>) -> Driver<Result<T, Moya.MoyaError>> {
        
        return ob.asDriver(onErrorRecover: { error in
            let x  = error as! Moya.MoyaError;
            return Driver.just(Result(error: x))
        })
    }
}


open class PFSValidate {
    
    public static func of<E>(_ elements: Result<E,MoyaError> ...) -> Driver<Result<Bool,MoyaError>> {
        
        let errror = elements.first {
            return $0.error != nil
        }
        
        let result: Result<Bool,MoyaError> = Result {
            if let error = errror{
                throw error.error!
            }
            
            return true
        }
        
        
        return Driver.just(result)
    }
    
}

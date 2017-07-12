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

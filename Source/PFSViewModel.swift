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



extension String: ReactiveCompatible {}

extension String {
    
    public typealias VResult = Result<String?, MoyaError>


    public func notNul(message: String) -> VResult {
        let result: VResult = VResult {
            if (self.characters.count) < 0 {
                throw MoyaError.underlying(VResult.error(message))
            }
            
            return self
        }
        
        return result
    }
    
    public func min(length: Int, message: String) -> VResult {
        let result: VResult = VResult {
            if (self.characters.count) < length {
                
                
                
                throw MoyaError.underlying(VResult.error(message))
            }
            
            return self
        }
        
        return result
    }
    
    public func max(length: Int, message: String) -> VResult {
        let result: VResult = VResult {
            if (self.characters.count) > length {
                throw MoyaError.underlying(VResult.error(message))
            }
            
            return self
        }
        
        return result
    }
    
    

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

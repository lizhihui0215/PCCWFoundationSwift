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
    
    func alert(message: String, success: Bool) -> Driver<Bool>
    
    func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void)
}

extension PFSViewAction {
    public func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void){
        
    }
    
    func alert(message: String) -> Driver<Bool> {
       return self.alert(message: message, success: true)
    }
}



extension String: ReactiveCompatible {}

extension String {
    
    public typealias VResult = Result<String?, MoyaError>


    public func notNul(message: String) -> VResult {
        let result: VResult = VResult {
            if self.characters.count <= 0 {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func min(length: Int, message: String, isContain: Bool = false) -> VResult {
        let result: VResult = VResult {
            if isContain, self.characters.count <= length {
                throw error(message: message)
            }else if self.characters.count < length {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func max(length: Int, message: String, isContain: Bool = false) -> VResult {
        let result: VResult = VResult {
            if isContain, self.characters.count >= length {
                throw error(message: message)
            }else if self.characters.count > length {
                throw error(message: message)
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
    
    #if DEBUG
    deinit {
        debug("DEBUG", model: type(of: self), content: "deinit")
    }
    #endif
}

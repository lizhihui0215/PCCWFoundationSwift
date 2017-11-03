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
    
    func confirm<T>(content: (String, T?)) -> Driver<(String, Bool, T?)>
    
    var animation: Variable<Bool> { get }
    
    func toast<T>(result: Result<T, MoyaError>) -> Driver<Result<T, MoyaError>>
    
    func toast(message: String) -> Driver<Bool>
    
}

extension PFSViewAction {
    public func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void){
        
    }
    
    public func alert<T>(result: Result<T, MoyaError>) -> Driver<Bool> {
        switch result {
        case .failure(let error):
            return alert(message: error.errorDescription!, success: false)
        case.success:
            return Driver.just(true)
        }
    }

    public func alert(message: String) -> Driver<Bool> {
       return self.alert(message: message, success: true)
    }
    
    public func toast<T>(result: Result<T, MoyaError>) -> Driver<Bool> {
        switch result {
        case .failure(let error):
            return toast(message: error.errorDescription!)
        case.success:
            return Driver.just(true)
        }
    }
}


extension String: ReactiveCompatible {}

extension Array {
    public typealias VResult = Result<Array?, MoyaError>

    public func notEmpty(message: String) -> VResult {
        let result: VResult = VResult {
            if self.isEmpty {
                throw error(message: message)
            }
            
            return self
        }
        return result
    }
}

extension String {
    public typealias VResult = Result<String?, MoyaError>

    public func notNull(message: String) -> VResult {
        let result: VResult = VResult {
            if self.count <= 0 {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func same(message: String, _ same: String) -> VResult {
        let result: VResult = VResult {
            if self.count <= 0, self != same {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func phone(message: String) -> VResult {
        let regex  = NSPredicate(format: "SELF MATCHES %@", "^(((0\\d{2,3}-)?\\d{7,8})|(1[123456789]\\d{9}))$")
        
        let result: VResult = VResult {
            if !regex.evaluate(with: self) {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func min(length: Int, message: String, isContain: Bool = false) -> VResult {
        let result: VResult = VResult {
            if isContain, self.count <= length {
                throw error(message: message)
            }else if self.count < length {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func max(length: Int, message: String, isContain: Bool = false) -> VResult {
        let result: VResult = VResult {
            if isContain, self.count >= length {
                throw error(message: message)
            }else if self.count > length {
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

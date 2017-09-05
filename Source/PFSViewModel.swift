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
    
    func alert(message: String, success: Bool) -> Observable<Bool>
    
    func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void)
    
    func confirm<T>(message: String, content: T?) -> Observable<T?>
}

extension PFSViewAction {
    public func animation<T>(_ task: (Driver<Result<T, MoyaError>>) -> Void){
        
    }
    
    func alert(message: String) -> Observable<Bool> {
       return self.alert(message: message, success: true)
    }
    
    func confirm<T>(message: String) -> Observable<T?> {
        return self.confirm(message: message)
    }
}



extension String: ReactiveCompatible {}

extension String {
    
    public typealias VResult = Result<String?, MoyaError>


    public func notNull(message: String) -> VResult {
        let result: VResult = VResult {
            if self.characters.count <= 0 {
                throw error(message: message)
            }
            
            return self
        }
        
        return result
    }
    
    public func same(message: String, _ same: String) -> VResult {
        let result: VResult = VResult {
            if self.characters.count <= 0, self != same {
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

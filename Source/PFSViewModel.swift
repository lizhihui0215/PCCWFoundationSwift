//
// Created by 李智慧 on 09/05/2017.
//

import Foundation
import RxCocoa

public protocol PFSViewAction: class {

}




enum PFSValidate {
    case notNull
    case minLength(Int)
    case maxLength(Int)
    
    func validate(message: String) -> Driver<String> {
        switch self {
        case .notNull:
            ""
        case .minLength(let min):
            ""
        case .maxLength(let max):
            ""
        }
        
        return Driver.just("")
    }
}


open class PFSViewModel {
    weak var action: PFSViewAction?

    public init(action: PFSViewAction) {
        self.action = action
    }
}

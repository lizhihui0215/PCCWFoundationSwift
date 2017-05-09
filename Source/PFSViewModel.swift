//
// Created by 李智慧 on 09/05/2017.
//

import Foundation

public protocol PFSViewAction: class {

}

open class PFSViewModel {
    weak var action: PFSViewAction?

    public init(action: PFSViewAction) {
        self.action = action
    }
}

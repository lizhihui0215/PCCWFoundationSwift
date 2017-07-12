//
//  Rx+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 12/07/2017.
//
//

import UIKit
import RxSwift
import RxCocoa

private let driverErrorMessage = "`drive*` family of methods can be only called from `MainThread`.\n" +
"This is required to ensure that the last replayed `Driver` element is delivered on `MainThread`.\n"

extension Driver {
    public func drive(onNext: ((E) -> Void)? = nil) -> Disposable {
        MainScheduler.ensureExecutingOnScheduler(errorMessage: driverErrorMessage)
        return self.asObservable().subscribe(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }
}

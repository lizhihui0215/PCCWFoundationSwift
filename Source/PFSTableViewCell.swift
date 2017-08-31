//
//  PFSTableViewCell.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 19/04/2017.
//
//

import UIKit
import RxCocoa
import RxSwift

open class PFSTableViewCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    open override func awakeFromNib() {
        self.layoutMargins = UIEdgeInsets.zero //or UIEdgeInsetsMake(top, left, bottom, right)
        self.separatorInset = UIEdgeInsets.zero //if you also want to adjust separatorInset
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
    
}

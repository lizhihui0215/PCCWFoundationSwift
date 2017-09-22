//
//  PFSCheckBox.swift
//  IBLNetAssistant
//
//  Created by 李智慧 on 16/07/2017.
//  Copyright © 2017 李智慧. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class PFSCheckbox: UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: #selector(PFSCheckbox.checkboxTapped), for: .touchUpInside)
    }
    
    @objc func checkboxTapped(_ sender: UIButton)  {
        sender.isSelected = !sender.isSelected
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

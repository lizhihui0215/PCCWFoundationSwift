//
//  SecondViewController.swift
//  Demo
//
//  Created by 李智慧 on 31/05/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

import UIKit
import PCCWFoundationSwift

class ScanViewController: LBXScanViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style = LBXScanViewStyle()
    }
}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

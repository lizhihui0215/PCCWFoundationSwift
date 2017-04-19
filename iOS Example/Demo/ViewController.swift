//
//  ViewController.swift
//  Demo
//
//  Created by 李智慧 on 19/04/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

import PCCWFoundationSwift
import Alamofire

class ViewController: PFSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("xx")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


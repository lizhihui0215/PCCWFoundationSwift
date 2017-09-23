//
//  ViewController.swift
//  Demo
//
//  Created by 李智慧 on 19/04/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//
import PCCWFoundationSwift
import Moya
import RxSwift
import RxCocoa
import Result



class XXXDomain: PFSPageDomain {
    
    
    func list()  {
        
    }
}

protocol PFSLoginAction: PFSViewAction {
    
}

class LoginDomain: PFSDomain {
    override init() {
        
    }
}


class LoginViewModel<T :PFSLoginAction>: PFSViewModel<T, LoginDomain> {
    
   
}

extension LoginViewController: PFSLoginAction {
    
}

class LoginViewController: PFSViewController  {
    
    @IBOutlet weak var testLabel: UILabel!
    
    lazy var viewModel: LoginViewModel<LoginViewController> = {
        let model = LoginViewModel(action: self, domain: LoginDomain())
        return model
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let model1 = self.viewModel
        
        let model2 = self.viewModel
        
        if model1 === model2 {
            print("Yes")
        }else {
            print("No")
        }
        
        let c = Driver.just("")
        
        c.drive { cc in
            print(cc)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

import ObjectMapper

class Model: PFSModel {
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        
    }
    
    
}


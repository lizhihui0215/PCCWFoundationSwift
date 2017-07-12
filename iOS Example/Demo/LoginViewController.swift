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

enum APITarget: PFSTargetType {
    
    case test
    
    var baseURL: URL {
        return URL(string: "http://baidu.com")!
    }
    var path: String {
        return ""
    }
    var method: Moya.Method {
        return .post
    }
    var parameters: [String: Any]? {
        
        //        {"currentPage":1,"pageSize":10,"queryObj":{}}
        return ["page" : ["currentPage" : 1,
                          "pageSize" : 10,
                          "queryObj": ""]]
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        return .request
    }
    var validate: Bool {
        return false
    }
}

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
    
    func test(username: String, password: String) -> Driver<Bool> {
        

        var x = PFSValidate(content: "1")
            .notNull(message: "用户名不能为空")
            .max(length: 5, message: "最大长度不能超过5")
        
        let q = PFSValidate(content: "xxxqqqq")
            .notNull(message: "密码不能为空")
            .max(length: 5, message: "最大长度不能超过5")
        
        let result = PFSValidate.validate(validates: [x,q])
        
        
        
        return Driver.just(true)
    }
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


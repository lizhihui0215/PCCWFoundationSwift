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
    var headers: [String : String] {
        return ["xx" : "xx"]
    }

    
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
        
        
        let a = username.notNul(message: "用户名不能为空")
        
        let b = username.min(length: 3, message: "用户名不能小于3位")
        
        let c = username.max(length: 8, message: "用户名不能大于8位")
        
        
        let d = password.notNul(message: "密码不能为空")
        
        let e = password.min(length: 3, message: "密码不能小于3位")
        
        let f = password.max(length: 8, message: "密码不能大于8位")
        
        
        let h = Observable.just("hhhhhh")
        
        
        let j = Driver.just("jjjjjj")
        
        
        let fff = PFSValidate.of(a,b,c,d,e,f)
        
        fff.flatMapLatest {
            return (self.action?.alert(result: $0))!
            }.flatMapLatest { _ in
                return j
            }.drive(onNext: {
                print($0)
            }, onCompleted: {
                
            }) {
                
        }
        
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
        
        self.viewModel.test(username: "123456789", password: "xxxx")
        
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


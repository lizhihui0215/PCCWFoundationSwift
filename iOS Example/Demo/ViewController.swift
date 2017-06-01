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

enum XXX: PFSTargetType {
    
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


class XXXViewModel: PFSViewModel {
    override init(action: PFSViewAction) {
        super.init(action: action)
    }
    
    func test(username: String, password: String) -> Driver<Bool> {
        
        
        
        var x = PFSValidate(content: "1")
            .notNull(message: "用户名不能为空")
            .max(length: 5, message: "最大长度不能超过5")
        
        var q = PFSValidate(content: "xxxqqqq")
            .notNull(message: "密码不能为空")
            .max(length: 5, message: "最大长度不能超过5")
        
        
        let result = PFSValidate.validate(validates: [x,q])
        
        
        self.action?.alert(result: result)
        
        
        
        return Driver.just(true)
    }
}

class ViewController: PFSViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let a =  PFSNetworkService<XXX>.shared
        
        let b = PFSNetworkService<XXX>.shared
        
        var ss: String? = "qq"
        print(ss.orEmpty)
        
        
        ss = nil
        print(ss.orEmpty)
        
        testLabel.text = "xxxx"
        
        if a === b {
            print("yes")
        }else {
            print("no")
        }
        
        
        let viewModel = XXXViewModel(action: self)
        
        viewModel.test(username: "xx", password: "qq")
        
        
        a.request(.test).asObservable().subscribe(onNext: { (response) in
            print(response)
        }).disposed(by: disposeBag)
        
        b.request(.test).asObservable().subscribe(onNext: { (response) in
            print(response)
        }).disposed(by: disposeBag)
        
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


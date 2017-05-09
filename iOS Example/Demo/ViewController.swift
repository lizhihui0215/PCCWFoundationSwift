//
//  ViewController.swift
//  Demo
//
//  Created by 李智慧 on 19/04/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//
import PCCWFoundationSwift
import Moya

enum XXX: PFSTargetType {

    var baseURL: URL {
        return URL(string: "")!
    }
    var path: String {
        return ""
    }
    var method: Moya.Method {
        return .post
    }
    var parameters: [String: Any]? {
        return nil
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


class ViewController: PFSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       let a =  PFSNetworkService<XXX>.shared
        
        let b = PFSNetworkService<XXX>.shared
        
        if a === b {
            print("yes")
        }else {
            print("no")
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


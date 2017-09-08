//
//  URL+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 08/09/2017.
//
//

import Foundation

extension URL {
    public var queryParameters: [String : String]? {
        if let query = self.query {
            var parameters = [String : String]()
            let parameterPires = query.components(separatedBy: "&")
            
            for parameterPire in parameterPires {
                let keyValue = parameterPire.components(separatedBy: "=")
                
                let key = keyValue[0]
                
                let value = keyValue[1]
                
                parameters += [key : value]
            }
            
            return parameters
        }
        
        return nil
    }
}

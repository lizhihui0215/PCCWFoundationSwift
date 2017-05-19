//
// Created by 李智慧 on 02/05/2017.
//


import Moya
import Result
import RxSwift
import ObjectMapper
import Moya_ObjectMapper

public class PFSResponseMappableObject<T: Mappable>: Mappable {
    var message: String = ""
    
    var code: Int = -1
    
    var result: T?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map)  {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
        result <- map[PFSNetworkServiceStatic.__result]
    }
}

public class PFSResponseNil: Mappable {
    var message: String = ""
    
    var code: Int = -1
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
    }
}

public class PFSResponseObject<T>: Mappable {
    var message: String = ""
    
    var code: Int = -1
    
    var result: T?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map)  {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
        result <- map[PFSNetworkServiceStatic.__result]
    }
}

public class PFSResponseArray<T>: Mappable {
    var message: String = ""
    
    var code: Int = -1
    
    var result: [T] = []
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map)  {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
        result <- map[PFSNetworkServiceStatic.__result]
    }
}

public class PFSResponseMappableArray<T: Mappable>: Mappable {
    var message: String = ""
    
    var code: Int = -1
    
    var result: [T] = []
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map)  {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
        result <- map[PFSNetworkServiceStatic.__result]
    }
}

public protocol PFSTargetType: TargetType {
    
}


public func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

public enum PFSNetworkError: Swift.Error {
    case serverError(String)
}

public class PFSNetworkServiceStatic{
    internal static var _onceTracker = [String: Any]()
    fileprivate static var __message: String = "message"
    fileprivate static var __code: String = "code"
    fileprivate static var __result: String = "result"
}

public class PFSNetworkService<API: PFSTargetType>: PFSNetworkServiceStatic {
    
    let provider: RxMoyaProvider<API>

    public static var shared: PFSNetworkService {
        get {
            let token = "com.pccw.foundation.swift.network.service.token.\(String(describing: PFSNetworkService.self))" 
            

            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            if let shared = _onceTracker[token] {
                return shared as! PFSNetworkService<API>;
            }
            
            _onceTracker[token] = PFSNetworkService<API>()
            
            return _onceTracker[token] as! PFSNetworkService<API>
        }
    }

    open static func config(message: String, code: String, result: String) {
        __message = message
        __code = code
        __result = result
    }

    public override init(){
        provider = RxMoyaProvider(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    }
    
    public func request<T>(_ token: API) -> Observable<PFSResponseObject<T>> {
        return provider.request(token).mapObject(PFSResponseObject<T>.self)
    }
    
    public func request<T>(_ token: API) -> Observable<PFSResponseMappableArray<T>> {
        return provider.request(token).mapObject(PFSResponseMappableArray<T>.self)
    }
    
    public func request<T>(_ token: API) -> Observable<PFSResponseArray<T>> {
        return provider.request(token).mapObject(PFSResponseArray<T>.self)
    }
    
    public func request<T>(_ token: API) -> Observable<PFSResponseMappableObject<T>> {
        return provider.request(token).mapObject(PFSResponseMappableObject<T>.self)
    }
    
    public func request(_ token: API) -> Observable<PFSResponseNil> {
        return provider.request(token).mapObject(PFSResponseNil.self)
    }


}

//
// Created by 李智慧 on 02/05/2017.
//


import Moya
import Result
import RxSwift
import ObjectMapper
import Moya_ObjectMapper
import Alamofire
import KissXML

public class PFSResponseMappableObject<T: Mappable>: Mappable {
    var message: String = ""
    
    var code: String = "-1"
    
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
    
    var code: String = "-1"
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        message <- map[PFSNetworkServiceStatic.__message]
        code <- map[PFSNetworkServiceStatic.__code]
    }
}

public class PFSResponseObject<T>: Mappable {
    var message: String = ""
    
    var code: String = "-1"
    
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
    
    var code: String = "-1"
    
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
    
    var code: String = "-1"
    
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
    
    public final class func defaultEndpointMapping(for target: API) -> Endpoint<API> {
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)

        let headers = defaultEndpoint.httpHeaderFields
        
        defaultEndpoint.adding(newHTTPHeaderFields: ["APP_NAME": "MY_AWESOME_APP"])
        
        return defaultEndpoint
    }


    public override init(){
        provider = RxMoyaProvider<API>(endpointClosure: PFSNetworkService.defaultEndpointMapping,
                                       requestClosure: MoyaProvider.defaultRequestMapping,
                                       plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)],
                                       trackInflights: false)
        
    }
    
    // When a TargetType's path is empty, URL.appendingPathComponent may introduce trailing /, which may not be wanted in some cases
    // See: https://github.com/Moya/Moya/pull/1053
    // And: https://github.com/Moya/Moya/issues/1049
    public final class func url(for target: PFSTargetType) -> URL {
        if target.path.isEmpty {
            return target.baseURL
        }
        
        return target.baseURL.appendingPathComponent(target.path)
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

public struct SOAPEncoding: ParameterEncoding {
    
//    public static var `default`: SOAPEncoding { return SOAPEncoding() }
    
    var xml = ""
    
    init(_ fileName: String) {
        let filePath = Bundle.main.path(forResource: fileName, ofType: "xml")
        xml = try! String(contentsOfFile: filePath!, encoding: .utf8)
    }
    
    
    func method(name: String, param: [String : String]) -> String  {
        let document = try! XMLDocument(xmlString: xml, options: 0)
        
        let messages = document.rootElement()?.elements(forName: "message")
        
        let types = document.rootElement()?.forName("types")
        
        let schema = types?.forName("schema")
        
        let targetNamespace = schema?.attribute(forName: "targetNamespace")?.stringValue
        
        let namespace = XMLNode.namespace(withName: "ns1", stringValue: targetNamespace!)
        
        let message = messages?.filter{ $0.attribute(forName: "name")?.stringValue == name }.first
        
        let part = message?.forName("part")
        
        let parametersString = part?.attribute(forName: "element")?.stringValue
        
        let parameters = parametersString?.components(separatedBy: ":")
        
        let parameterName = parameters?.last
        
        let messageXX = XMLElement.element(withName: parameterName!) as! XMLElement
        
        messageXX.addNamespace(namespace as! DDXMLNode)
        
        let complexTypes = schema?.elements(forName: "complexType")
        
        let complexType = complexTypes?.filter{ $0.attribute(forName: "name")?.stringValue == name }.first
        
        let sequence = complexType?.forName("sequence")
        
        let xxxx = sequence?.children as? [XMLElement]?
        
        let ffff = xxxx??.map{  $0.attribute(forName: "name")?.stringValue }
        
        for f in ffff! {
            let value = param[f!]
            messageXX.addChild(XMLElement.element(withName: f!, stringValue: value!) as! DDXMLNode)
        }
        
        let root = XMLElement(name: "soap:Envelope")
        
        root.addNamespace(XMLNode.namespace(withName: "soap",
                                              stringValue: "http://schemas.xmlsoap.org/soap/envelope/") as! DDXMLNode)
        
        let header = XMLElement(name: "soap", stringValue: "Header")
        
        let body = XMLElement(name: "soap", stringValue: "Body")
        
        body.addChild(messageXX)
        
        root.addChild(header)
        
        root.addChild(body)
        
        return root.xmlString
        
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard parameters != nil else { return urlRequest }
        do {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = "data".data(using: .utf8)
        }
        catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
    
    
}

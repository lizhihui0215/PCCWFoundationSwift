//
// Created by 李智慧 on 09/05/2017.
//

import RxSwift
import RxCocoa
import Result
import Moya
import ObjectMapper

open class PFSDataRepository {
    
    public init() {
        
    }
    
    private static var dictionary = [String: Any]()
    
    public func put<T>(key: String, value: T) {
        PFSDataRepository.dictionary[key] = value
    }
    
    public func get<T>(key: String) -> T? {
        return PFSDataRepository.dictionary[key] as? T
    }
    
    public func save<T>(key: String, value: T) -> Bool{
        if basicType(value) {
            UserDefaults.standard.set(value, forKey: key)
        }else {
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            
            UserDefaults.standard.set(data, forKey: key)
        }
        
        return UserDefaults.standard.synchronize()
    }
    
    public func fetch<T>(key: String) -> T? {
        if basicType(T.self) {
            return UserDefaults.standard.value(forKey: key) as? T
        }else {
            let value = UserDefaults.standard.value(forKey: key)
            
            guard let data = value as? Data else {
                return nil
            }
            
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
        }
    }
    
    
    public func fetch<T: Mappable>(key: String) -> T? {
        
        guard let JSON = UserDefaults.standard.dictionary(forKey: key)  else {
            return nil
        }
            
        return Mapper<T>().map(JSON: JSON)
    }
    
    public func handlerError<T>(response: Observable<PFSResponseObject<T>>) -> Observable<Result<T?, MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message)
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T: Mappable>(response: Observable<PFSResponseMappableObject<T>>) -> Observable<Result<T?, MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message)
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T>(response: Observable<PFSResponseArray<T>>) -> Observable<Result<[T], MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message)
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T: Mappable>(response: Observable<PFSResponseMappableArray<T>>) -> Observable<Result<[T], MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message)
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError(response: Observable<PFSResponseNil>) -> Observable<Result<String, MoyaError>>  {
        
        return response.map{ response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message)
                }
                
                return response.message
            }
        }
    }
    
    
}

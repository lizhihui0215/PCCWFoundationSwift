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
    
    public func handlerError<T>(response: Observable<PFSResponseObject<T>>) -> Observable<Result<T?, MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code == "0" {
                    throw MoyaError.underlying(Result<T, MoyaError>.error(response.message))
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T: Mappable>(response: Observable<PFSResponseMappableObject<T>>) -> Observable<Result<T?, MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code == "0" {
                    throw MoyaError.underlying(Result<T, MoyaError>.error(response.message))
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T>(response: Observable<PFSResponseArray<T>>) -> Observable<Result<[T], MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code == "0" {
                    throw MoyaError.underlying(Result<[T], MoyaError>.error(response.message))
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError<T: Mappable>(response: Observable<PFSResponseMappableArray<T>>) -> Observable<Result<[T], MoyaError>>  {
        return response.map{ response in
            return Result {
                if response.code == "0" {
                    throw MoyaError.underlying(Result<[T], MoyaError>.error(response.message))
                }
                
                return response.result
            }
        }
    }
    
    public func handlerError(response: Observable<PFSResponseNil>) -> Observable<Result<String, MoyaError>>  {
        
        return response.map{ response in
            return Result {
                if response.code == "0" {
                    throw MoyaError.underlying(Result<String, MoyaError>.error(response.message))
                }
                
                return response.message
            }
        }
    }
    
    
}

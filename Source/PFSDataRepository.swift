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

    @discardableResult
    public func cache<T>(key: String, value: T?) -> Bool {
        if basicType(T.self) {
            UserDefaults.standard.set(value, forKey: key)
        }
        return UserDefaults.standard.synchronize()
    }

    public func cache<T>(key: String) -> T? {
        if basicType(T.self) {
            return UserDefaults.standard.value(forKey: key) as? T
        }

        return nil
    }

    public func handlerError<T>(response: Observable<PFSResponseObject<T>>) -> Driver<Result<T, MoyaError>> {
        return response.map { response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message, code: response.code, userInfo: ["response" : response])
                }
                return response.result!
            }
        }.asDriver { error in
            return Driver.just(Result(error: MoyaError.underlying(error)))
        }
    }

    public func handlerError<T:Mappable>(response: Observable<PFSResponseMappableObject<T>>) -> Driver<Result<T, MoyaError>> {
        return response.map { response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message, code: response.code, userInfo: ["response" : response])
                }
                return response.result!
            }
        }.asDriver { error in
            return Driver.just(Result(error: MoyaError.underlying(error)))
        }
    }

    public func handlerError<T>(response: Observable<PFSResponseArray<T>>) -> Driver<Result<[T], MoyaError>> {
        return response.map { response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message, code: response.code, userInfo: ["response" : response])
                }

                return response.result
            }
        }.asDriver { error in
            return Driver.just(Result(error: MoyaError.underlying(error)))
        }
    }

    public func handlerError<T:Mappable>(response: Observable<PFSResponseMappableArray<T>>) -> Driver<Result<[T], MoyaError>> {
        return response.map { response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message, code: response.code, userInfo: ["response" : response])
                }

                return response.result
            }
        }.asDriver { error in
            return Driver.just(Result(error: MoyaError.underlying(error)))
        }
    }

    public func handlerError(response: Observable<PFSResponseNil>) -> Driver<Result<String, MoyaError>> {

        return response.map { response in
            return Result {
                if response.code != "0" {
                    throw error(message: response.message, code: response.code, userInfo: ["response" : response])
                }

                return response.message
            }
        }.asDriver { error in
            return Driver.just(Result(error: MoyaError.underlying(error)))
        }
    }
}

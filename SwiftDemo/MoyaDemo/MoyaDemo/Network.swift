//
//  Network.swift
//  MoyaDemo
//
//  Created by kfw on 2020/12/14.
// 包装适配器

import Foundation
import Moya
//import SwiftyJSON

struct Network {
//    static let provider = MoyaProvider<MyService>()

//    static func request(
//        target: MyService,
//        success successCallback: (JSON) -> Void,
//        error errorCallback:(_ statusCode: Int) -> Void,
//        failure failureCallback: (MoyaError) -> Void
//    ) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    try response.filterSuccessfulStatusCodes()
//                    let json = try JSON(response.mapJSON())
//                    successCallback(json)
//                }
//                catch {
////                    errorCallback(error)
//                }
////            case let .failure(error):
////                if target.shouldRetry {
////                    retryWhenReachable(target, successCallback, errorCallback, failureCallback)
////                }
////                else {
////                    failureCallback(error)
////                }
//            case .failure(error):
//                break
//            }
//        }
//    }
    
//    @discardableResult
//    static func request(_ target: Target,
//                      callbackQueue: DispatchQueue? = .none,
//                      progress: ProgressBlock? = .none,
//                      completion: @escaping Completion) -> Cancellable {
//
//        let callbackQueue = callbackQueue ?? self.callbackQueue
//        return requestNormal(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
//    }
}

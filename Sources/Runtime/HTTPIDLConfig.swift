//
//  HTTPIDLConfig.swift
//  HTTPIDLDemo
//
//  Created by 徐 东 on 2016/11/30.
//  Copyright © 2016年 dx lab. All rights reserved.
//

import Foundation
import Alamofire

public protocol HTTPIDLConfiguration {
    var baseURLString: String {get set}
    var headers: [String: String] {get set}
    
    mutating func append(headers: [String: String])
}

public struct BaseHTTPIDLConfiguration: HTTPIDLConfiguration {
    public static var shared = BaseHTTPIDLConfiguration()
    
    public var baseURLString: String = ""
    public var headers: [String: String] = [:]
    
    public mutating func append(headers: [String: String]) {
        let newHeader = headers.reduce(self.headers , { (soFar, soGood) in
            var mutableSoFar = soFar
            mutableSoFar[soGood.0] = soGood.1
            return mutableSoFar
        })
        self.headers = newHeader
    }
}

public extension HTTPIDLRequest {
    static var defaultEncoder: HTTPRequestEncoder {
        get {
            switch self.defaultMethod {
            case "POST", "PUT", "PATCH":
                return HTTPURLEncodedFormRequestEncoder.shared
            default:
                return HTTPURLEncodedQueryRequestEncoder.shared
            }
        }
    }
}

public extension HTTPIDLResponse {
    static var defaultDecoder: HTTPResponseDecoder {
        get {
            return HTTPResponseJSONDecoder.shared
        }
    }
}
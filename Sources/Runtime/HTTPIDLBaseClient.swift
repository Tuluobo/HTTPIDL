//
//  HTTPIDLBaseClient.swift
//  everfilter
//
//  Created by 徐 东 on 2016/12/31.
//  Copyright © 2016年 Shanghai Infinite Memory. All rights reserved.
//

import Foundation

public enum HTTPIDLBaseClientError: Error {
    case noResponse
}

public class HTTPIDLBaseClient: HTTPIDLClient {
    
    public static let shared = HTTPIDLBaseClient()
    private var clientImpl: HTTPClient = AlamofireClient()
    private var requestObservers: [HTTPRequestObserver] = []
    private var responseObservers: [HTTPResponseObserver] = []
    private var requestRewriters: [HTTPRequestRewriter] = []
    private var responseRewriters: [HTTPResponseRewriter] = []
    
    private let requestObserverQueue: DispatchQueue = DispatchQueue(label: "httpidl.requestObserver")
    private let responseObserverQueue: DispatchQueue = DispatchQueue(label: "httpidl.responseObserver")
    private let requestRewriterQueue: DispatchQueue = DispatchQueue(label: "httpidl.requestRewriter")
    private let responseRewriterQueue: DispatchQueue = DispatchQueue(label: "httpidl.responseRewriter")
    
    public func add(requestObserver: HTTPRequestObserver) {
        requestObserverQueue.sync {
            requestObservers.append(requestObserver)
        }
    }
    
    public func remove(requestObserver: HTTPRequestObserver) {
        requestObserverQueue.sync {
            if let index = requestObservers.index(where: { (observer) -> Bool in
                return observer === requestObserver
            }) {
                requestObservers.remove(at: index)
            }
        }
    }
    
    public func add(responseObserver: HTTPResponseObserver) {
        responseObserverQueue.sync {
            responseObservers.append(responseObserver)
        }
    }
    
    public func remove(responseObserver: HTTPResponseObserver) {
        responseObserverQueue.sync {
            if let index = responseObservers.index(where: { (observer) -> Bool in
                return observer === responseObserver
            }) {
                responseObservers.remove(at: index)
            }
        }
    }
    
    public func add(requestRewriter: HTTPRequestRewriter) {
        requestRewriterQueue.sync {
            self.requestRewriters.append(requestRewriter)
        }
    }
    
    public func remove(requestRewriter: HTTPRequestRewriter) {
        requestRewriterQueue.sync {
            if let index = requestRewriters.index(where: { (rewriter) -> Bool in
                return rewriter === requestRewriter
            }) {
                requestRewriters.remove(at: index)
            }
        }
    }
    
    public func add(responseRewriter: HTTPResponseRewriter) {
        responseRewriterQueue.sync {
            self.responseRewriters.append(responseRewriter)
        }
    }
    
    public func remove(responseRewriter: HTTPResponseRewriter) {
        responseRewriterQueue.sync {
            if let index = responseRewriters.index(where: { (rewriter) -> Bool in
                return rewriter === responseRewriter
            }) {
                responseRewriters.remove(at: index)
            }
        }
    }

    
    private func willSend(request: HTTPIDLRequest) {
        requestObserverQueue.async {
            self.requestObservers.forEach { (observer) in
                observer.willSend(request: request)
            }
        }
    }
    private func didSend(request: HTTPIDLRequest) {
        requestObserverQueue.async {
            self.requestObservers.forEach { (observer) in
                observer.didSend(request: request)
            }
        }
    }
    private func willEncode(request: HTTPIDLRequest) {
        requestObserverQueue.async {
            self.requestObservers.forEach { (observer) in
                observer.willEncode(request: request)
            }
        }
    }
    private func didEncode(request: HTTPIDLRequest, encoded: HTTPRequest) {
        requestObserverQueue.async {
            self.requestObservers.forEach { (observer) in
                observer.didEncode(request: request, encoded: encoded)
            }
        }
    }
    
    private func receive(error: Error) {
        responseObserverQueue.async {
            self.responseObservers.forEach { (observer) in
                observer.receive(error: error)
            }
        }
    }
    
    private func receive(rawResponse: HTTPResponse) {
        responseObserverQueue.async {
            self.responseObservers.forEach { (observer) in
                observer.receive(rawResponse: rawResponse)
            }
        }
    }
    
    private func willDecode(rawResponse: HTTPResponse) {
        responseObserverQueue.async {
            self.responseObservers.forEach { (observer) in
                observer.willDecode(rawResponse: rawResponse)
            }
        }
    }
    private func didDecode(rawResponse: HTTPResponse, decodedResponse: HTTPIDLResponse) {
        responseObserverQueue.async {
            self.responseObservers.forEach { (observer) in
                observer.didDecode(rawResponse: rawResponse, decodedResponse: decodedResponse)
            }
        }
    }
    
    private func rewrite(request: HTTPRequest) -> HTTPRequestRewriterResult? {
        var ret: HTTPRequestRewriterResult? = nil
        requestRewriterQueue.sync {
            var req = request
            for rewriter in requestRewriters {
                let rewriterResult = rewriter.rewrite(request: req)
                switch rewriterResult {
                    //如果任何一个结果被重写成了response或error都结束循环，直接返回最后的rewrite结果
                    //如果重写后还是一个request，则将重写后的request交给下一个rewriter重写，如果后面没有rewriter了，就将这次重写的结果返回
                    case .request(let rewritedRequest):
                        req = rewritedRequest
                    default: break
                }
                ret = rewriterResult
            }
        }
        return ret
    }
    
    private func rewrite(response: HTTPResponse) -> HTTPResponseRewriterResult? {
        var ret: HTTPResponseRewriterResult? = nil
        requestRewriterQueue.sync {
            var resp = response
            for rewriter in responseRewriters {
                let rewriterResult = rewriter.rewrite(response: resp)
                switch rewriterResult {
                    //如果任何一个结果被重写成了error都结束循环，直接返回最后的rewrite结果
                    //如果重写后还是一个response，则将重写后的response交给下一个rewriter重写，如果后面没有rewriter了，就将这次重写的结果返回
                case .response(let rewritedResponse):
                    resp = rewritedResponse
                default: break
                }
                ret = rewriterResult
            }
        }
        return ret
    }
    
    private func handle<ResponseType : HTTPIDLResponse>(response: HTTPResponse, responseDecoder: HTTPResponseDecoder, completion: @escaping (ResponseType) -> Void, errorHandler: ((Error) -> Void)?) {
        var resp = response
        if let responseRewriteResult = self.rewrite(response: response) {
            switch responseRewriteResult {
            case .response(let rewritedResponse):
                resp = rewritedResponse
            case .error(let error):
                self.handle(error: error, errorHandler: errorHandler)
                return
            }
        }
        self.receive(rawResponse: resp)
        self.willDecode(rawResponse: resp)
        do {
            let parameters = try responseDecoder.decode(resp)
            let httpIdlResponse = try ResponseType(parameters: parameters, rawResponse: resp)
            completion(httpIdlResponse)
            self.didDecode(rawResponse: resp, decodedResponse: httpIdlResponse)
        }catch let error {
            self.handle(error: error, errorHandler: errorHandler)
        }
    }
    
    private func handle(response: HTTPResponse, completion: @escaping (HTTPResponse) -> Void, errorHandler: ((Error) -> Void)?) {
        var resp = response
        if let responseRewriteResult = self.rewrite(response: response) {
            switch responseRewriteResult {
            case .response(let rewritedResponse):
                resp = rewritedResponse
            case .error(let error):
                self.handle(error: error, errorHandler: errorHandler)
                return
            }
        }
        completion(resp)
        self.receive(rawResponse: resp)
    }
    
    private func handle(error: Error, errorHandler: ((Error) -> Void)?) {
        errorHandler?(error)
        self.receive(error: error)
    }
    
    public func send<ResponseType : HTTPIDLResponse>(_ request: HTTPIDLRequest, requestEncoder: HTTPRequestEncoder, responseDecoder: HTTPResponseDecoder, completion: @escaping (ResponseType) -> Void, errorHandler: ((Error) -> Void)?) {
        do {
            self.willSend(request: request)
            self.willEncode(request: request)
            var encodedRequest = try requestEncoder.encode(request)
            self.didEncode(request: request, encoded: encodedRequest)
            if let rewriterResult = self.rewrite(request: encodedRequest) {
                switch rewriterResult {
                case .request(let rewritedRequest):
                    encodedRequest = rewritedRequest
                case .response(let response):
                    self.handle(response: response, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
                case .error(let error):
                    self.handle(error: error, errorHandler: errorHandler)
                }
            }
            clientImpl.send(encodedRequest, completion: { (response) in
                self.handle(response: response, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
            }, errorHandler: { (error) in
                self.handle(error: error, errorHandler: errorHandler)
            })
            self.didSend(request: request)
        } catch let error {
            self.handle(error: error, errorHandler: errorHandler)
        }
    }
    
    public func send(_ request: HTTPIDLRequest, requestEncoder: HTTPRequestEncoder, completion: @escaping (HTTPResponse) -> Void, errorHandler: ((Error) -> Void)?) {
        do {
            self.willSend(request: request)
            self.willEncode(request: request)
            var encodedRequest = try requestEncoder.encode(request)
            self.didEncode(request: request, encoded: encodedRequest)
            
            if let rewriterResult = self.rewrite(request: encodedRequest) {
                switch rewriterResult {
                case .request(let rewritedRequest):
                    encodedRequest = rewritedRequest
                case .response(let response):
                    self.handle(response: response, completion: completion, errorHandler: errorHandler)
                case .error(let error):
                    self.handle(error: error, errorHandler: errorHandler)
                }
            }
            clientImpl.send(encodedRequest, completion: { (response) in
                self.handle(response: response, completion: completion, errorHandler: errorHandler)
            }, errorHandler: { (error) in
                self.handle(error: error, errorHandler: errorHandler)
            })
            self.didSend(request: request)
        } catch let error {
            self.handle(error: error, errorHandler: errorHandler)
        }
    }
}
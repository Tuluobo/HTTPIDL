//这是自动生成的代码，不要改动，否则你的改动会被覆盖！！！！！！！

import Foundation
import HTTPIDL


class GetTestUrlencodedQueryEncoderRequest: Request {
    
    static let defaultMethod: String = "GET"
    var method: String = GetTestUrlencodedQueryEncoderRequest.defaultMethod
    var configuration: Configuration = BaseConfiguration.shared
    var client: Client = BaseClient.shared
    var uri: String {
        get {
            return "/test/urlencoded/query/encoder"
        }
    }
    var t1: Int64?
    var t2: Int32?
    var t3: Double?
    var t4: String?
    var content: RequestContent? {
        var result = [String:RequestContent]()
        if let tmp = t1 {
            result["t"] = tmp.asRequestContent()
        }
        if let tmp = t2 {
            result["tt"] = tmp.asRequestContent()
        }
        if let tmp = t3 {
            result["ttt"] = tmp.asRequestContent()
        }
        if let tmp = t4 {
            result["tttt"] = tmp.asRequestContent()
        }
        return .dictionary(value: result)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = GetTestUrlencodedQueryEncoderRequest.defaultEncoder, responseDecoder: HTTPResponseDecoder = GetTestUrlencodedQueryEncoderResponse.defaultDecoder, completion: @escaping (GetTestUrlencodedQueryEncoderResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = GetTestUrlencodedQueryEncoderRequest.defaultEncoder, rawResponseHandler: @escaping (HTTPResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, completion: rawResponseHandler, errorHandler: errorHandler)
    }
}

struct GetTestUrlencodedQueryEncoderResponse: Response {
    
    let x1: String?
    let rawResponse: HTTPResponse
    init(content: ResponseContent?, rawResponse: HTTPResponse) throws {
        self.rawResponse = rawResponse
        guard let content = content, case .dictionary(let value) = content else {
            self.x1 = nil
            return
        }
        self.x1 = String(content: value["x"])
    }
}

class PostTestUrlencodedFormEncoderRequest: Request {
    
    static let defaultMethod: String = "POST"
    var method: String = PostTestUrlencodedFormEncoderRequest.defaultMethod
    var configuration: Configuration = BaseConfiguration.shared
    var client: Client = BaseClient.shared
    var uri: String {
        get {
            return "/test/urlencoded/form/encoder"
        }
    }
    var t1: Int64?
    var t2: Int32?
    var t3: Double?
    var t4: String?
    var content: RequestContent? {
        var result = [String:RequestContent]()
        if let tmp = t1 {
            result["t"] = tmp.asRequestContent()
        }
        if let tmp = t2 {
            result["tt"] = tmp.asRequestContent()
        }
        if let tmp = t3 {
            result["ttt"] = tmp.asRequestContent()
        }
        if let tmp = t4 {
            result["tttt"] = tmp.asRequestContent()
        }
        return .dictionary(value: result)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestUrlencodedFormEncoderRequest.defaultEncoder, responseDecoder: HTTPResponseDecoder = PostTestUrlencodedFormEncoderResponse.defaultDecoder, completion: @escaping (PostTestUrlencodedFormEncoderResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestUrlencodedFormEncoderRequest.defaultEncoder, rawResponseHandler: @escaping (HTTPResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, completion: rawResponseHandler, errorHandler: errorHandler)
    }
}

struct PostTestUrlencodedFormEncoderResponse: Response {
    
    let x1: String?
    let rawResponse: HTTPResponse
    init(content: ResponseContent?, rawResponse: HTTPResponse) throws {
        self.rawResponse = rawResponse
        guard let content = content, case .dictionary(let value) = content else {
            self.x1 = nil
            return
        }
        self.x1 = String(content: value["x"])
    }
}

class PostTestMultipartEncoderRequest: Request {
    
    static let defaultMethod: String = "POST"
    var method: String = PostTestMultipartEncoderRequest.defaultMethod
    var configuration: Configuration = BaseConfiguration.shared
    var client: Client = BaseClient.shared
    var uri: String {
        get {
            return "/test/multipart/encoder"
        }
    }
    var t1: Int64?
    var t2: Int32?
    var t3: Double?
    var t4: String?
    var t5: HTTPData?
    var content: RequestContent? {
        var result = [String:RequestContent]()
        if let tmp = t1 {
            result["t"] = tmp.asRequestContent()
        }
        if let tmp = t2 {
            result["tt"] = tmp.asRequestContent()
        }
        if let tmp = t3 {
            result["ttt"] = tmp.asRequestContent()
        }
        if let tmp = t4 {
            result["tttt"] = tmp.asRequestContent()
        }
        if let tmp = t5 {
            result["tttttt"] = tmp.asRequestContent()
        }
        return .dictionary(value: result)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestMultipartEncoderRequest.defaultEncoder, responseDecoder: HTTPResponseDecoder = PostTestMultipartEncoderResponse.defaultDecoder, completion: @escaping (PostTestMultipartEncoderResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestMultipartEncoderRequest.defaultEncoder, rawResponseHandler: @escaping (HTTPResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, completion: rawResponseHandler, errorHandler: errorHandler)
    }
}

struct PostTestMultipartEncoderResponse: Response {
    
    let x1: String?
    let rawResponse: HTTPResponse
    init(content: ResponseContent?, rawResponse: HTTPResponse) throws {
        self.rawResponse = rawResponse
        guard let content = content, case .dictionary(let value) = content else {
            self.x1 = nil
            return
        }
        self.x1 = String(content: value["x"])
    }
}

class PostTestJsonEncoderRequest: Request {
    
    static let defaultMethod: String = "POST"
    var method: String = PostTestJsonEncoderRequest.defaultMethod
    var configuration: Configuration = BaseConfiguration.shared
    var client: Client = BaseClient.shared
    var uri: String {
        get {
            return "/test/json/encoder"
        }
    }
    var t1: Int64?
    var t2: Int32?
    var t3: Double?
    var t4: String?
    var t5: [String]?
    var content: RequestContent? {
        var result = [String:RequestContent]()
        if let tmp = t1 {
            result["t"] = tmp.asRequestContent()
        }
        if let tmp = t2 {
            result["tt"] = tmp.asRequestContent()
        }
        if let tmp = t3 {
            result["ttt"] = tmp.asRequestContent()
        }
        if let tmp = t4 {
            result["tttt"] = tmp.asRequestContent()
        }
        if let tmp = t5 {
            result["ttttt"] = tmp.asRequestContent()
        }
        return .dictionary(value: result)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestJsonEncoderRequest.defaultEncoder, responseDecoder: HTTPResponseDecoder = PostTestJsonEncoderResponse.defaultDecoder, completion: @escaping (PostTestJsonEncoderResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, responseDecoder: responseDecoder, completion: completion, errorHandler: errorHandler)
    }
    func send(_ requestEncoder: HTTPRequestEncoder = PostTestJsonEncoderRequest.defaultEncoder, rawResponseHandler: @escaping (HTTPResponse) -> Void, errorHandler: @escaping (HIError) -> Void) {
        client.send(self, requestEncoder: requestEncoder, completion: rawResponseHandler, errorHandler: errorHandler)
    }
}

struct PostTestJsonEncoderResponse: Response {
    
    let x1: String?
    let rawResponse: HTTPResponse
    init(content: ResponseContent?, rawResponse: HTTPResponse) throws {
        self.rawResponse = rawResponse
        guard let content = content, case .dictionary(let value) = content else {
            self.x1 = nil
            return
        }
        self.x1 = String(content: value["x"])
    }
}

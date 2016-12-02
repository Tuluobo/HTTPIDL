//这是自动生成的代码，不要改动，否则你的改动会被覆盖！！！！！！！

import Foundation
import Alamofire


struct SettingsURITemplate: JSONObject {
    
    let avatar: String?
    let thumbnail: String?
    let origin: String?
    init?(with json: Any?) {
        if let json = json as? [String: Any] {
            self.avatar = String(with: json["avatar"])
            self.thumbnail = String(with: json["s240"])
            self.origin = String(with: json["origin"])
        } else {
            return nil
        }
    }
}

struct SettingsOnlineFilter: JSONObject {
    
    let name: String?
    let displayName: String?
    init?(with json: Any?) {
        if let json = json as? [String: Any] {
            self.name = String(with: json["name"])
            self.displayName = String(with: json["display_name"])
        } else {
            return nil
        }
    }
}

struct ApplicationSettingsStruct: JSONObject {
    
    let tagVersion: Int32?
    let smsCode: String?
    let uriTemplateDict: [String: String]?
    let uriTemplate: SettingsURITemplate?
    let onlineFilter: [SettingsOnlineFilter]?
    init?(with json: Any?) {
        if let json = json as? [String: Any] {
            self.tagVersion = Int32(with: json["system_tag_version"])
            self.smsCode = String(with: json["sms_code_number"])
            if let anyDict = json["uri_template"] as? [String: Any] {
                var tmp: [String: String] = [:]
                anyDict.forEach({ (key, value) in
                    guard let newKey = String(with: key) else {
                        return
                    }
                    guard let newValue = String(with: value) else {
                        return
                    }
                    tmp[newKey] = newValue
                })
                if tmp.count > 0 {
                    self.uriTemplateDict = tmp
                } else {
                    self.uriTemplateDict = nil
                }
            } else {
                self.uriTemplateDict = nil
            }
            self.uriTemplate = SettingsURITemplate(with: json["uri_template"])
            if let anyArray = json["filters"] as? [Any] {
                self.onlineFilter = anyArray.flatMap { SettingsOnlineFilter(with: $0) }
            } else {
                self.onlineFilter = nil
            }
        } else {
            return nil
        }
    }
}

class GetApplicationSettingsRequest {
    
    var configuration = HTTPIDLConfiguration.shared
    var test: [Int32]?
    func parameters() -> [String: Any] {
        var result: [String: Any] = [:]
        if let tmp = test {
            result["hahahah"] = tmp
        }
        return result
    }
    
    func send(with completion: @escaping (GetApplicationSettingsResponse, Error?) -> Void) {
        prepare().responseJSON { (dataResponse) in
            switch dataResponse.result {
                case .failure(let error):
                    let responseModel = GetApplicationSettingsResponse(with: nil, rawResponse: dataResponse.response)
                    completion(responseModel, error)
                case .success(let data):
                    let responseModel = GetApplicationSettingsResponse(with: data, rawResponse: dataResponse.response)
                    completion(responseModel, nil)
            }
        }
    }
    func prepare() -> DataRequest {
        return Alamofire.request(configuration.baseURLString + "/application/settings", method:.get, parameters: parameters(), encoding: configuration.parameterEncoding, headers: configuration.headers)
    }
}

struct GetApplicationSettingsResponse: RawHTTPResponseWrapper {
    
    let settings: ApplicationSettingsStruct?
    let rawResponse: HTTPURLResponse?
    init(with json: Any?, rawResponse: HTTPURLResponse?) {
        self.rawResponse = rawResponse
        if let json = json as? [String: Any] {
            self.settings = ApplicationSettingsStruct(with: json["data"])
        } else {
            self.settings = nil
        }
    }
}

class PostFiltersShinkaiRequest {
    
    var configuration = HTTPIDLConfiguration.shared
    var image: URL?
    func parameters() -> [String: Any] {
        var result: [String: Any] = [:]
        if let tmp = image {
            result["media"] = tmp
        }
        return result
    }
    
    func prepare(encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        var dest = configuration.baseURLString + "/filters/shinkai"
        if var urlComponents = URLComponents(string: dest) {
            var queryItems = urlComponents.queryItems ?? []
            urlComponents.queryItems = queryItems
            if let urlString = urlComponents.string {
                dest = urlString
            }
        }
        Alamofire.upload(multipartFormData: { (multipart) in
            if let tmp = self.image {
                multipart.append(tmp, withName: "media")
            }
        }, to: dest, encodingCompletion: encodingCompletion)
    }
    func send(with completion: @escaping (PostFiltersShinkaiResponse, Error?) -> Void) {
        prepare(encodingCompletion: { (encodingResult) in
            switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { (dataResponse) in
                        switch dataResponse.result {
                            case .failure(let error):
                                let responseModel = PostFiltersShinkaiResponse(with: nil, rawResponse: dataResponse.response)
                                completion(responseModel, error)
                            case .success(let data):
                                let responseModel = PostFiltersShinkaiResponse(with: data, rawResponse: dataResponse.response)
                                completion(responseModel, nil)
                        }
                    }
                case .failure(let encodingError):
                let responseModel = PostFiltersShinkaiResponse(with: nil, rawResponse: nil)
                completion(responseModel, encodingError)
            }
        })
    }
}

struct PostFiltersShinkaiResponse: RawHTTPResponseWrapper {
    
    let rawResponse: HTTPURLResponse?
    init(with json: Any?, rawResponse: HTTPURLResponse?) {
        self.rawResponse = rawResponse
        if let json = json as? [String: Any] {
        } else {
        }
    }
}

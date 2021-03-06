//
//  RequestContent.swift
//  everfilter
//
//  Created by 徐 东 on 2017/1/2//

import Foundation

public protocol RequestContentKeyType {
    func asHTTPParamterKey() -> String
}

public protocol RequestContentConvertible {
    func asRequestContent() -> RequestContent
}

public enum RequestContent {
    case number(value: NSNumber)
    case string(value: String)
    case file(value: URL, fileName: String?, mimeType: String?)
    case data(value: Data, fileName: String?, mimeType: String?)
    case array(value: [RequestContent])
    case dictionary(value: [String: RequestContent])
}

extension Int64: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension Int64: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension UInt64: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension UInt64: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension Int: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension Int: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension UInt: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension UInt: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension Int32: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension Int32: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension UInt32: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension UInt32: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension Bool: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}


extension Double: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return String(self)
    }
}

extension Double: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: NSNumber(value: self))
    }
}

extension String: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return self
    }
}

extension String: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .string(value: self)
    }
}

extension NSString: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return self as String
    }
}

extension NSString: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .string(value: self as String)
    }
}

extension NSNumber: RequestContentKeyType {
    public func asHTTPParamterKey() -> String {
        return self.stringValue
    }
}

extension NSNumber: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        return .number(value: self)
    }
}

extension Array where Element: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        let value = self.map ({ (convertible) in
            return convertible.asRequestContent()
        })
        return .array(value: value)
    }
}

extension Array where Element == RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        let value = self.map ({ (convertible) in
            return convertible.asRequestContent()
        })
        return .array(value: value)
    }
}

extension Dictionary where Key: RequestContentKeyType, Value: RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        let value = self.reduce([String: RequestContent]()) { (soFar, soGood) -> [String: RequestContent] in
            var result = soFar
            result[soGood.key.asHTTPParamterKey()] = soGood.value.asRequestContent()
            return result
        }
        return .dictionary(value: value)
    }
}

extension Dictionary where Key: RequestContentKeyType, Value == RequestContentConvertible {
    public func asRequestContent() -> RequestContent {
        let value = self.reduce([String: RequestContent]()) { (soFar, soGood) -> [String: RequestContent] in
            var result = soFar
            result[soGood.key.asHTTPParamterKey()] = soGood.value.asRequestContent()
            return result
        }
        return .dictionary(value: value)
    }
}


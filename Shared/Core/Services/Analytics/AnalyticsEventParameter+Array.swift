//
//  AnalyticsEventParameter.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

extension Array where Element == AnalyticsEventParameterProtocol {
    public func toDictionary() -> [String: Any] {
        reduce(into: [:]) { result, param in
            result[param.key] = param.value
        }
    }
    
    public func toStringDictionary() -> [String: String] {
        reduce(into: [:]) { result, param in
            result[param.key] = String(describing: param.value)
        }
    }
    
    public mutating func merge(parameters: [AnalyticsEventParameterProtocol]) {
        guard !parameters.isEmpty else {
            return
        }
        guard !isEmpty else {
            self = parameters
            return
        }
        var dict = toDictionary()
        dict.merge(parameters.toDictionary()) { _, new in new }
        self = dict.reduce(into: []) { result, entry in
            let (key, value) = entry
            result.append(AnalyticsEventParameter(key: key, value: value))
        }
    }
    
    public mutating func remove(parameters: [AnalyticsEventParameterProtocol]) {
        let keys = parameters.map { $0.key }
        removeAll { entry in
            keys.contains(entry.key)
        }
    }
}

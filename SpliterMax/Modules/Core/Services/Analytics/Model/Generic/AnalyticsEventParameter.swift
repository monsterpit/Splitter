//
//  AnalyticsEventParameter.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public protocol AnalyticsEventParameterProtocol {
    var key: String { get }
    var value: Any { get }
}

public struct AnalyticsEventParameter: AnalyticsEventParameterProtocol {
    public let key: String
    public let value: Any
    
    public init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
}

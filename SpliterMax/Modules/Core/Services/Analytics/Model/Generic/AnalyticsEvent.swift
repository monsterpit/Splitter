//
//  AnalyticsEvent.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public protocol AnalyticsEventProtocol {
    var name: String { get }
    var parameters: [AnalyticsEventParameterProtocol] { get }
    var scope: AnalyticsEventScope { get }
    
    func map(providerId: String) -> AnalyticsEventProtocol
}

public extension AnalyticsEventProtocol {
    var scope: AnalyticsEventScope {
        .default
    }
    
    func map(providerId: String) -> AnalyticsEventProtocol {
        self
    }
}

public struct AnalyticsEvent: AnalyticsEventProtocol {
    public let name: String
    public let parameters: [AnalyticsEventParameterProtocol]
    public let scope: AnalyticsEventScope
    
    public init(name: String, parameters: [AnalyticsEventParameterProtocol] = [], scope: AnalyticsEventScope = .default) {
        self.name = name
        self.parameters = parameters
        self.scope = scope
    }
}

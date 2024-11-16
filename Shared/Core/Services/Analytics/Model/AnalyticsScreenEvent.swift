//
//  AnalyticsScreenEvent.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import UIKit

public struct AnalyticsScreenEvent: AnalyticsEventProtocol {
    public let name = "App_Screen_view"
    public let scope: AnalyticsEventScope
    public let screenName: String
    public let screenClass: String
    
    public var parameters: [AnalyticsEventParameterProtocol] {
        [
            AnalyticsEventParameter.screenName(value: screenName)
        ]
    }
    
    public init(screenName: String, screenClass: String, scope: AnalyticsEventScope = .default) {
        self.screenName = screenName
        self.screenClass = screenClass
        self.scope = scope
    }
}

extension AnalyticsEventParameter {
    static func screenName(value: Any) -> Self {
        .init(key: "screen_name", value: value)
    }

    static func screenClass(value: Any) -> Self {
        .init(key: "screen_class", value: value)
    }
}


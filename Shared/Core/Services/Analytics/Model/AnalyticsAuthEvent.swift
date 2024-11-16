//
//  AnalyticsAuthEvent.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public enum AnalyticsAuthEvent: AnalyticsEventProtocol {
    case login, signup, logout
    
    public var name: String {
        switch self {
        case .login:
            "login"
        case .signup:
            "sign_up"
        case .logout:
            "logout"
        }
    }
    
    public var parameters: [AnalyticsEventParameterProtocol] {
        []
    }
}

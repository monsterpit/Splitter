//
//  AnalyticsEventScope.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public enum AnalyticsEnvironment: Hashable {
    case dev, uat, prod
}

public struct AnalyticsEventScope {
    public enum Providers {
        case all
        case limited(providersIds: Set<String>)
        
        func isValid(providerId: String) -> Bool {
            switch self {
            case .all:
                true
            case .limited(let providersIds):
                providersIds.contains(providerId)
            }
        }
    }
    
    public enum Environment {
        case any
        case limited(environments: Set<AnalyticsEnvironment>)
        
        func isValid(environment: AnalyticsEnvironment) -> Bool {
            switch self {
            case .any:
                true
            case .limited(let environments):
                environments.contains(environment)
            }
        }
    }
    
    public let providers: Providers
    public let environment: Environment
    
    public static let `default`: AnalyticsEventScope = .init(providers: .all, environment: .any)
}


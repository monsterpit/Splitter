//
//  AnalyticsService.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol AnalyticsServiceProtocol {
    func track(event: AnalyticsEventProtocol)
    
    func setUser(_ user: AnalyticsUser)
    func clearUser(_ user: AnalyticsUser)
    
    func setGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol])
    func removeGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol])
}

public final class AnalyticsService {
    private let providers: [AnalyticsProviderProtocol]
    private let environment: AnalyticsEnvironment
    
    public init(providers: [AnalyticsProviderProtocol], environment: AnalyticsEnvironment) {
        self.providers = providers
        self.environment = environment
    }
}

extension AnalyticsService: AnalyticsServiceProtocol {
    public func track(event: AnalyticsEventProtocol) {
        guard event.scope.environment.isValid(environment: environment) else {
            return
        }
        providers.forEach {
            if event.scope.providers.isValid(providerId: $0.providerId) {
                $0.track(event: event.map(providerId: $0.providerId))
            }
        }
    }
    
    public func setUser(_ user: AnalyticsUser) {
        providers.forEach { $0.setUser(user) }
    }
    
    public func clearUser(_ user: AnalyticsUser) {
        providers.forEach { $0.clearUser(user) }
    }
    
    public func setGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol]) {
        providers.forEach { $0.setGlobalParameters(parameters) }
    }
    
    public func removeGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol]) {
        providers.forEach { $0.removeGlobalParameters(parameters) }
    }
}

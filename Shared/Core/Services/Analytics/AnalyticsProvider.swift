//
//  AnalyticsProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol AnalyticsProviderProtocol {
    var providerId: String { get }
    
    func track(event: AnalyticsEventProtocol)
    
    func setUser(_ user: AnalyticsUser)
    func clearUser(_ user: AnalyticsUser)
    
    func setGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol])
    func removeGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol])
}


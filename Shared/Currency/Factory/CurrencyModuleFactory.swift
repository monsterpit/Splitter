//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Infrastructure
import Services

public protocol CurrencyModuleFactoryProtocol {
    func create(coordinator: CurrencyExternalNavigationProtocol?) -> CurrencyCoordinatorProtocol
}

public protocol CurrencyModuleConfigurationFactoryProtocol {
    var logger: LoggerProtocol { get }
    var analyticsService: AnalyticsServiceProtocol { get }
}

public struct CurrencyModuleFactory: CurrencyModuleFactoryProtocol {
    private let configFactory: CurrencyModuleConfigurationFactoryProtocol
    public init(configFactory: CurrencyModuleConfigurationFactoryProtocol) {
        self.configFactory = configFactory
    }

    public func create(coordinator: CurrencyExternalNavigationProtocol?) -> CurrencyCoordinatorProtocol {
        CurrencyCoordinator(parentCoordinator: coordinator,
                            screenFactory: CurrencyScreenFactory(configFactory: configFactory))
    }
}

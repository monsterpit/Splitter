//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Currency
import Infrastructure
import LocalizationKit
import Services
import SharedCoreUI
import SwiftUI
import Swinject
import SwinjectAutoregistration
import UIKit
import Utils

extension ScreenName {
    static var currency: Self { .selfName() }
}

struct CurrencyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TabViewProtocol.self,
                           name: ScreenName.currency.rawValue)
        { (resolver, coordinator: MainTabBarCoordinatorProtocol) in

            let configFactory = CurrencyModuleConfigurationFactory(resolver: resolver)
            let factory = CurrencyModuleFactory(configFactory: configFactory)
            let externalCoordinator = CurrencyExternalCoordinator(parentCoordinator: coordinator, screenFactory: nil)
            let view = factory.create(coordinator: externalCoordinator).start(route: .root)
            externalCoordinator.viewHolder = view.holder

            return TabContainerView(tabTitle: StringConstants.ok,
                                    tabImage: UIImage(resource: .Help.Info.bold),
                                    tabImageSelected: UIImage(resource: .Help.Info.bold))
            {
                view
            }
        }
    }
}

extension CurrencyAssembly {
    struct CurrencyScreenConfiguration {
        let coordinator: ParentCoordinatorProtocol?
    }

    struct CurrencyModuleConfigurationFactory: CurrencyModuleConfigurationFactoryProtocol {
        let resolver: Resolver

        var logger: LoggerProtocol {
            resolver ~> (LoggerProtocol.self, name: LoggersAssembly.LoggerName.composer)
        }

        var analyticsService: AnalyticsServiceProtocol {
            resolver~>
        }
    }
}

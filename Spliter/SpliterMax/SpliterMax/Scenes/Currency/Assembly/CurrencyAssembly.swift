//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Currency
import Infrastructure
import LocalizationKit
import Services
import SharedCoreUI
import SwiftUI
import UIKit
import Utils

extension ScreenName {
    static var currency: Self { .selfName() }
}

struct CurrencyAssembly {
    var currencyTab: TabContainerView

    init(config: CurrencyScreenConfiguration) {
//        let currencyView = CurrencyView()
//        let wow = UIImage(named: "globe")
//        // UIImage(systemName: "house.fill") ??
//        currencyTab = TabContainerView(tabTitle: "explore",
//                                      tabImage: UIImage(resource: .Help.Info.bold),
//                                      tabImageSelected: UIImage(resource: .Help.Info.bold))
//        {
//            currencyView
//        }

        let configFactory = CurrencyModuleConfigurationFactory()
        let factory = CurrencyModuleFactory(configFactory: configFactory)
        let externalCoordinator = CurrencyExternalCoordinator(parentCoordinator: config.coordinator, screenFactory: nil)
        let view = factory.create(coordinator: externalCoordinator).start(route: .root)
        externalCoordinator.viewHolder = view.holder

        currencyTab = TabContainerView(tabTitle: StringConstants.ok,
                                       tabImage: UIImage(resource: .Help.Info.bold),
                                       tabImageSelected: UIImage(resource: .Help.Info.bold))
        {
            view
        }
    }
}

extension CurrencyAssembly {
    struct CurrencyScreenConfiguration {
        let coordinator: ParentCoordinatorProtocol?
    }

    struct CurrencyModuleConfigurationFactory: CurrencyModuleConfigurationFactoryProtocol {
        var logger: LoggerProtocol {
            LoggerAssembly.logger
        }

        var analyticsService: AnalyticsServiceProtocol {
            Application.shared.assembler.analyticsService
        }
    }
}

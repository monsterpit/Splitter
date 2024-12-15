//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import SharedCoreUI
import Utils

enum CurrencyScreen {
    case main(coordinator: CurrencyViewNavigationProtocol)
}

protocol CurrencyScreenFactoryProtocol {
    func makeScreen(_ screen: CurrencyScreen) -> (any ViewControllableProtocol)
}

struct CurrencyScreenFactory: CurrencyScreenFactoryProtocol {
    private let configFactory: CurrencyModuleConfigurationFactoryProtocol

    init(configFactory: CurrencyModuleConfigurationFactoryProtocol) {
        self.configFactory = configFactory
    }

    func makeScreen(_ screen: CurrencyScreen) -> (any ViewControllableProtocol) {
        switch screen {
        case let .main(coordinator):
            let viewModel = CurrencyViewModel(coordinator: coordinator,
                                              logger: configFactory.logger)
            return CurrencyView(viewModel: viewModel)
        }
    }
}

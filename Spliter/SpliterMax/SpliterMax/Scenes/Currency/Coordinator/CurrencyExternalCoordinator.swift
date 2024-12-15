//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Currency
import Foundation
import Utils

final class CurrencyExternalCoordinator: ParentCoordinator {
    private weak var mainCoordinator: MainTabBarCoordinatorProtocol?
    let screenFactory: ScreenFactoryProtocol?

    init(parentCoordinator: MainTabBarCoordinatorProtocol?,
         screenFactory: ScreenFactoryProtocol?,
         autoRemove: Bool = true)
    {
        mainCoordinator = parentCoordinator
        self.screenFactory = screenFactory
        super.init(parentCoordinator: parentCoordinator, autoRemove: autoRemove)

        mainCoordinator?.addTabCoordinator(self)
    }

    init(parentCoordinator: (any ParentCoordinatorProtocol)?, screenFactory: ScreenFactoryProtocol?) {
        self.screenFactory = screenFactory
        super.init(parentCoordinator: parentCoordinator, autoRemove: false)
    }

    override func childDidFinish(_ child: any CoordinatorProtocol) {
        super.childDidFinish(child)
        if coordinators.isEmpty {
            parentCoordinator?.childDidFinish(self)
        }
    }
}

extension CurrencyExternalCoordinator: CurrencyExternalNavigationProtocol {}

extension CurrencyExternalCoordinator: MainTabCoordinatorProtocol {
    var tab: MainTab {
        .currency
    }

    func handle(activity _: MainTabActivity) {}
}

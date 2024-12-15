//
//  MainScreensAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
import Utils

extension ScreenName {
    static var main: Self { .selfName() }
}

struct MainScreensAssembly {
    private var exploreAssembly: ExploreAssembly
    private var currencyAssembly: CurrencyAssembly

    let mainTabViews: MainTabBarController

    init(config: MainScreenConfiguration) {
        exploreAssembly = ExploreAssembly()
        currencyAssembly = CurrencyAssembly(config: CurrencyAssembly.CurrencyScreenConfiguration(coordinator: config.coordinator))

        let mainTabbarCoordinator = MainTabBarCoordinator(parentCoordinator: config.coordinator)
        let mainViewModel = MainViewModel(coordinator: mainTabbarCoordinator)
        mainTabViews = MainTabBarController(viewModel: mainViewModel)
        mainTabbarCoordinator.viewHolder = mainTabViews
        let tabs = tabViews(coordinator: mainTabbarCoordinator)
            .sorted { $0.0.index < $1.0.index }
            .map(\.1)
        mainTabViews.setTabViews(tabs)
    }

    func tabViews(coordinator _: MainTabBarCoordinatorProtocol) -> [(MainTab, TabViewProtocol)] {
        [
            (.explore, exploreAssembly.exploreTab),
            (.currency, currencyAssembly.currencyTab),
            (.wallet, exploreAssembly.exploreTab),
            (.profile, exploreAssembly.exploreTab),
        ]
    }
}

struct MainScreenConfiguration {
    let coordinator: RootCoordinatorProtocol
}

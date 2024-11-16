//
//  MainScreensAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

extension ScreenName {
    static var main: Self { .selfName() }
}

struct MainScreensAssembly {
    private static var exploreAssembly: ExploreAssembly { ExploreAssembly() }
    let mainTabViews: MainTabBarController

    init(config: MainScreenConfiguration) {
        let mainTabbarCoordinator = MainTabBarCoordinator(parentCoordinator: config.coordinator)
        let mainViewModel = MainViewModel(coordinator: mainTabbarCoordinator)
        mainTabViews = MainTabBarController(viewModel: mainViewModel)
        mainTabbarCoordinator.viewHolder = mainTabViews
        let tabs = MainScreensAssembly.tabViews(coordinator: mainTabbarCoordinator)
            .sorted { $0.0.index < $1.0.index }
            .map(\.1)
        mainTabViews.setTabViews(tabs)
    }

    static func tabViews(coordinator _: MainTabBarCoordinatorProtocol) -> [(MainTab, TabViewProtocol)] {
        [
            (.explore, exploreAssembly.exploreTab),
            (.trips, exploreAssembly.exploreTab),
            (.wallet, exploreAssembly.exploreTab),
            (.profile, exploreAssembly.exploreTab),
        ]
    }
}

struct MainScreenConfiguration {
    let coordinator: RootCoordinatorProtocol
}

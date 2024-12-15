//
//  MainScreensAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Swinject
import SwinjectAutoregistration
import UIKit
import Utils

extension ScreenName {
    static var main: Self { .selfName() }
}

struct MainScreensAssembly: Assembly {
    static var assemblies: [Assembly] {
        [
            MainScreensAssembly(),
            ExploreAssembly(),
            CurrencyAssembly(),
        ]
    }

    func assemble(container: Swinject.Container) {
        container.register(UIViewController.self, name: ScreenName.main.rawValue) { (_, config: MainScreenConfiguration) in
            let coordinator = MainTabBarCoordinator(parentCoordinator: config.coordinator)
            let viewModel = MainViewModel(coordinator: coordinator)
            let view = MainTabBarController(viewModel: viewModel)
            coordinator.viewHolder = view

            let tabs = tabViews(resolver: container, coordinator: coordinator)
                .sorted { $0.0.index < $1.0.index }
                .map(\.1)
            view.setTabViews(tabs)
            return view
        }
    }

    private func tabViews(resolver: Resolver, coordinator: MainTabBarCoordinatorProtocol) -> [(MainTab, TabViewProtocol)] {
        [
            (.explore, resolver ~> (TabViewProtocol.self, name: ScreenName.explore.rawValue, argument: coordinator)),
            (.currency, resolver ~> (TabViewProtocol.self, name: ScreenName.currency.rawValue, argument: coordinator)),
            (.explore, resolver ~> (TabViewProtocol.self, name: ScreenName.explore.rawValue, argument: coordinator)),
            (.explore, resolver ~> (TabViewProtocol.self, name: ScreenName.explore.rawValue, argument: coordinator)),
        ]
    }
}

struct MainScreenConfiguration {
    let coordinator: RootCoordinatorProtocol
}

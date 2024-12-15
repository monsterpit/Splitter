//
//  RootAssembler.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
import Infrastructure
import Swinject
import SwinjectAutoregistration
import Utils

extension ScreenName {
    static var launch: Self { .selfName() }
    static var jailBreak: Self { .selfName() }
}

struct RootScreenAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(ScreenFactoryProtocol.self) { resolver in
            ScreenFactory(resolver: resolver)
        }

        container.register(RootCoordinator.self) { resolver in
            RootCoordinator(appState: .init(viewLoadTracker: ViewLoadTracker(delegate: resolver~>),
                                            networkMonitor: resolver~>), screenFactory: resolver~>,
                            logger: resolver ~> (LoggerProtocol.self, name: LoggersAssembly.LoggerName.composer))
        }
        .inObjectScope(.weak)

        container.register(RootViewModel.self) { resolver in
            RootViewModel(coordinator: resolver~>)
        }

        container.registerScreen(.launch) { (resolver: Resolver, config: ScreenConfiguration<RootCoordinatorProtocol>) in
            let coordinator = LaunchCoordinator(rootCoordinator: config.coordinator)
            let viewModel = LaunchViewModel(coordinator: coordinator, userService: resolver~>)
            let view = LaunchView(viewModel: viewModel)
            coordinator.viewHolder = view.holder
            return view.viewController
        }

        container.registerScreen(.jailBreak) { (_: Resolver, config: ScreenConfiguration<RootCoordinatorProtocol>) in
            let coordinator = JailBreakCoordinator(rootCoordinator: config.coordinator)
            let viewModel = JailBreakViewModel(coordinator: coordinator)
            let view = JailBreakView(viewModel: viewModel)
            coordinator.viewHolder = view.holder
            return view.viewController
        }
    }
}

//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Infrastructure
import Services
import Swinject
import SwinjectAutoregistration
import Utils

class ServicesAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        assembleUserServices(container: container)
        assembleApplicationSessionServices(container: container)

        assembleAnalytics(container: container)
    }

    private func assembleUserServices(container: Container) {
        container.register(UserServiceProtocol.self) { resolver in
            UserService(repository: resolver~>)
        }

        container.register(UserServiceAsyncProtocol.self) { resolver in
            UserService(repository: resolver~>)
        }
    }

    private func assembleApplicationSessionServices(container: Container) {
        container.register(ApplicationSessionServiceProtocol.self) { resolver in
            ApplicationSessionService(repository: resolver~>)
        }
        .inObjectScope(.container)
    }

    private func assembleAnalytics(container: Container) {
        container.register(ViewLoadTrackerDelegateProtocol.self) { resolver in
            ScreenViewTracker(analytics: resolver~>)
        }
        .inObjectScope(.weak)

        container.register([AnalyticsProviderProtocol].self) { resolver in
            #if DEBUG
                [
                    LogAnalyticsProvider(
                        logger: resolver ~> (LoggerProtocol.self, name: LoggersAssembly.LoggerName.analytics)
                    ),
                ]
            #else
                [
                    FirebaseAnalyticsProvider(),
                    HeapAnalyticsProvider(),
                ]
            #endif
        }

        container.register(AnalyticsServiceProtocol.self) { resolver in
            AnalyticsService(providers: resolver~>, environment: .init(environment: Environment.current))
        }
        .inObjectScope(.container)
    }
}

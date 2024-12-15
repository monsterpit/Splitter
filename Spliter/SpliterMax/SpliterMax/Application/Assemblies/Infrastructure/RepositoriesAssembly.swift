//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//
import Domain
import Foundation
import Infrastructure
import Services
import Swinject
import SwinjectAutoregistration

struct RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        registerAuthRepository(container: container)
        registerNetworkMonitorRepository(container: container)
        registerUserRepository(container: container)
        registerApplicationSessionRepository(container: container)
    }

    private func registerAuthRepository(container: Container) {
        container.register(AuthRepository.self) { _ in
            AuthRepository()
        }
        .inObjectScope(.container)
        .implements(AuthRepositoryCleanupProtocol.self)
    }

    private func registerNetworkMonitorRepository(container: Container) {
        container.register(NetworkMonitorRepositoryProtocol.self) { _ in
            NetworkMonitorRepository()
        }
        .inObjectScope(.container)
    }

    private func registerUserRepository(container: Container) {
        container.register(UserRepository.self) { resolver in
            UserRepository(logger: resolver ~> (LoggerProtocol.self,
                                                name: LoggersAssembly.LoggerName.composer),
                           storage: resolver~>)
        }
        .inObjectScope(.container)
        .implements(UserRepositoryProtocol.self)
    }

    private func registerApplicationSessionRepository(container: Container) {
        container.register(ApplicationSessionRepositoryProtocol.self) { resolver in
            ApplicationSessionRepository(storage: resolver~>,
                                         authRepository: resolver~>,
                                         appName: Environment.appName)
        }
        .inObjectScope(.container)
    }
}

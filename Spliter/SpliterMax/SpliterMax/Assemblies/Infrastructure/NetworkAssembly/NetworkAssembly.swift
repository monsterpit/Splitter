//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Infrastructure
import Swinject
import SwinjectAutoregistration

struct NetworkAssembly: Assembly {
    func assemble(container: Container) {
        registerRestApi(container: container)
    }

    private func registerRestApi(container: Container) {
        container.register(NetworkRestServiceProtocol.self) { _ in
            NetworkServiceUrlSession(urlSession: URLSession.shared)
        }
        container.register(NetworkApiClientProtocol.self) { resolver in
            RestAPIClient(baseURL: Environment.configuration.gatewayUrl, networkService: resolver~>)
        }
        .inObjectScope(.weak)
    }
}

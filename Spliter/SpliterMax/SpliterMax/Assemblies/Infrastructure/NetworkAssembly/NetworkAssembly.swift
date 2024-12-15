//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Infrastructure
import Swinject

struct NetworkAssembly {
    let restAPIClient: RestAPIClient
    init() {
        let networkService = NetworkServiceUrlSession(urlSession: URLSession.shared)
        restAPIClient = RestAPIClient(baseURL: Environment.configuration.gatewayUrl, networkService: networkService)
    }

    private mutating func registerRestApi() {}
}

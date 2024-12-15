//
// Copyright (c) 2023-present The Collinson Group Limited. All Rights Reserved.
//

import Foundation

public final class RestAPIClient: NetworkApiClientProtocol {
    public let baseURL: String
    private let networkService: NetworkRestServiceProtocol

    public init(baseURL: String, networkService: NetworkRestServiceProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }

    public func dispatch<R: Request>(_ request: R) async throws -> (data: R.ReturnType, headers: [AnyHashable: Any]) {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            throw NetworkRequestError.badRequest
        }
        do {
            let data = try await networkService.dispatch(request: urlRequest, responseType: R.ReturnType.self)
            return data
        } catch {
            throw error
        }
    }
}

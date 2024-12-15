//
// Copyright (c) 2023-present The Collinson Group Limited. All Rights Reserved.
//

import Foundation

public final class NetworkServiceUrlSession: NetworkRestServiceProtocol {
    let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func dispatch<ReturnType: Decodable>(request: URLRequest, responseType: ReturnType.Type) async throws -> (data: ReturnType, headers: [AnyHashable: Any]) {
        do {
            let (data, response) = try await urlSession.data(for: request)
            var responseHeaders: [AnyHashable: Any] = [:]

            if let httpResponse = response as? HTTPURLResponse {
               if !(200...299).contains(httpResponse.statusCode) {
                    throw httpError(httpResponse.statusCode)
                }
                responseHeaders = httpResponse.allHeaderFields
            }
            let responseData = try JSONDecoder().decode(ReturnType.self, from: data)
            return (responseData, responseHeaders)
        } catch {
            throw handleError(error)
        }
    }

    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }

    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let networkError as NetworkRequestError:
            return networkError
        default:
            return .unknownError
        }
    }
}

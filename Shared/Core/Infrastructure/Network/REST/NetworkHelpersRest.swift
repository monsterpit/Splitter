//
// Copyright (c) 2023-present The Collinson Group Limited. All Rights Reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

enum HTTPBaseUrls: String {
    case authSuperToken = ""
}

extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }

        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}

public protocol NetworkRestServiceProtocol {
    func dispatch<ReturnType: Decodable>(request: URLRequest, responseType: ReturnType.Type) async throws -> (data: ReturnType, headers: [AnyHashable: Any])
}

public protocol NetworkApiClientProtocol {
    var baseURL: String { get }
    func dispatch<R: Request>(_ request: R) async throws -> (data: R.ReturnType, headers: [AnyHashable: Any])
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    var method: HTTPMethod { .get }
    var contentType: String { "application/json" }
    var queryParams: [String: String]? { nil }
    var headers: [String: String]? { nil }

    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"

        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}

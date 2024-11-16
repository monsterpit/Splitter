//
//  LogAnalyticsProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

final class LogAnalyticsProvider: AnalyticsProviderProtocol {
    static let id = "LogAnalytics"

    var providerId: String {
        Self.id
    }

    private let logger: LoggerProtocol
    private var globalParameters: [AnalyticsEventParameterProtocol] = []

    init(logger: LoggerProtocol) {
        self.logger = logger
    }

    func track(event: AnalyticsEventProtocol) {
        let attrs: [String: String] = [event.parameters, globalParameters].flatMap { $0 }.toStringDictionary()
        logger.info("[ANALYTICS] \(event.name)", attributes: attrs)
    }

    func setUser(_ user: AnalyticsUser) {
        logger.info("[ANALYTICS] did set user", attributes: user.parameters.toStringDictionary())
    }

    func clearUser(_ user: AnalyticsUser) {
        logger.info("[ANALYTICS] did clear user", attributes: user.parameters.toStringDictionary())
    }

    func setGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol]) {
        logger.info("[ANALYTICS] set global parameters", attributes: parameters.toStringDictionary())
        globalParameters.merge(parameters: parameters)
    }

    func removeGlobalParameters(_ parameters: [AnalyticsEventParameterProtocol]) {
        logger.info("[ANALYTICS] remove global parameters", attributes: parameters.toStringDictionary())
        globalParameters.remove(parameters: parameters)
    }
}

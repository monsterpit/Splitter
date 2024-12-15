//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation

public final class LoggerComposer: LoggerProtocol {
    public let loggers: [LoggerProtocol]

    public init(loggers: [LoggerProtocol]) {
        self.loggers = loggers
    }

    public func debug(_ message: String, attributes: [String: String]) {
        loggers.forEach { $0.debug(message, attributes: attributes) }
    }

    public func info(_ message: String, attributes: [String: String]) {
        loggers.forEach { $0.info(message, attributes: attributes) }
    }

    public func notice(_ message: String, attributes: [String: String]) {
        loggers.forEach { $0.notice(message, attributes: attributes) }
    }

    public func warning(_ message: String, attributes: [String: String]) {
        loggers.forEach { $0.warning(message, attributes: attributes) }
    }

    public func error(message: String, attributes: [String: String] = [:]) {
        loggers.forEach { $0.error(message: message, attributes: attributes) }
    }

    public func error(_ err: Error, attributes: [String: String] = [:]) {
        loggers.forEach { $0.error(err, attributes: attributes) }
    }

    public func critical(_ message: String, attributes: [String: String]) {
        loggers.forEach { $0.critical(message, attributes: attributes) }
    }

    public func set(severityLevel: SeverityLevel) {
        loggers.forEach { $0.set(severityLevel: severityLevel) }
    }

    public func addAttribute(key: GlobalAttribute, value: String) {
        loggers.forEach { $0.addAttribute(key: key, value: value) }
    }

    public func removeAttribute(key: GlobalAttribute) {
        loggers.forEach { $0.removeAttribute(key: key) }
    }

    public func setUserInfo(id: String, name: String?, email: String?) {
        loggers.forEach { $0.setUserInfo(id: id, name: name, email: email) }
    }

    public func removeUserInfo() {
        loggers.forEach { $0.removeUserInfo() }
    }
}

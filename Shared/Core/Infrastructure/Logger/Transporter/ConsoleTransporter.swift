//
//  ConsoleTransporter.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

final class ConsoleTransporter: LogTransporter {
    private let environmentName: String
    private var severityLevel: SeverityLevel
    private let includeGlobalAttributes: Bool
    private var customOutputStream: TextOutputStream?
    private var globalAttributes: [String: String] = [:]
    private var id: String?
    private var name: String?
    private var email: String?
    
    init(environmentName: String,
         severityLevel: SeverityLevel,
         includeGlobalAttributes: Bool = true,
         customOutputStream: TextOutputStream? = nil) {
        self.environmentName = environmentName
        self.severityLevel = severityLevel
        self.includeGlobalAttributes = includeGlobalAttributes
        self.customOutputStream = customOutputStream
    }

    func debug(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes
        
        logMessage("[DEBUG]", message, mergedAttributes, level: .debug)
    }
    
    func info(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes

        logMessage("ℹ️ [INFO]", message, mergedAttributes, level: .info)
    }
    
    func notice(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes

        logMessage("🔵 [NOTICE]", message, mergedAttributes, level: .notice)
    }
    
    func warning(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes

        logMessage("⚠️ [WARNING]", message, mergedAttributes, level: .warning)
    }
    
    func error(message: String, attributes: [String: String] = [:]) {
        logErrorMessage(message, attributes: attributes)
    }
    
    func error(_ err: Error, attributes: [String: String] = [:]) {
        var message = err.localizedDescription
        logErrorMessage(message, attributes: attributes)
    }
    
    private func logErrorMessage(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes
        let consoleMessage = "\nError: \(message)"
        logMessage("🔥 [ERROR]", consoleMessage, mergedAttributes, level: .error)
    }
    
    func critical(_ message: String, attributes: [String: String] = [:]) {
        let mergedAttributes = includeGlobalAttributes ? globalAttributes.merging(attributes) { _, new in new } : attributes

        logMessage("⛔️ [CRITICAL]", message, mergedAttributes, level: .critical)
    }
    
    func set(severityLevel: SeverityLevel) {
        self.severityLevel = severityLevel
    }
    
    func addAttribute(key: GlobalAttribute, value: String) {
        globalAttributes[key.rawValue] = value
    }

    func removeAttribute(key: GlobalAttribute) {
        globalAttributes.removeValue(forKey: key.rawValue)
    }
    
    func setUserInfo(id: String, name: String?, email: String?) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    func removeUserInfo() {
        id = nil
        name = nil
        email = nil
    }
    
    private func logMessage(_ prefix: String,
                            _ message: String,
                            _ attributes: [String: String],
                            level: SeverityLevel) {
        guard level.rawValue >= severityLevel.rawValue else {
            return // Skip logs with lower severity level
        }

        let logMessage = "\(prefix) \(environmentName) - \(message) \(formatAttributes(attributes))"

        if var customOutputStream {
            customOutputStream.write(logMessage)
        } else {
#if DEBUG
            print(logMessage)
#endif
        }
    }
    
    private func formatAttributes(_ attributes: [String: String]) -> String {
        guard !attributes.isEmpty else {
            return ""
        }
        
        let formattedAttributes = attributes.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
        return "[\(formattedAttributes)]"
    }
}


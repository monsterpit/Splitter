//
//  Logger.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol LoggerProtocol {
    func debug(_ message: String, attributes: [String: String])
    func info(_ message: String, attributes: [String: String])
    func notice(_ message: String, attributes: [String: String])
    func warning(_ message: String, attributes: [String: String])
    func error(message: String, attributes: [String: String])
    func error(_ err: Error, attributes: [String: String])
    func critical(_ message: String, attributes: [String: String])
    func set(severityLevel: SeverityLevel)
    func addAttribute(key: GlobalAttribute, value: String)
    func removeAttribute(key: GlobalAttribute)
    func setUserInfo(id: String, name: String?, email: String?)
    func removeUserInfo()
}

public extension LoggerProtocol {
    func debug(_ message: String) { debug(message, attributes: [:]) }
    func info(_ message: String) { info(message, attributes: [:]) }
    func notice(_ message: String) { notice(message, attributes: [:]) }
    func warning(_ message: String) { warning(message, attributes: [:]) }
    func error(message: String, attributes: [String: String] = [:]) {
        error(message: message, attributes: attributes)
    }

    func error(_ err: Error, attributes: [String: String] = [:]) {
        error(err, attributes: attributes)
    }

    func critical(_ message: String) { critical(message, attributes: [:]) }
}

// sourcery: AutoMockable
protocol LogTransporter: LoggerProtocol {}

public final class Logger {
    public enum Configuration {
        case console(environmentName: String,
                     severityLevel: SeverityLevel)
    }
    
    let configuration: Configuration
    var logTransporter: LogTransporter?
    
    public init(configuration: Configuration) {
        self.configuration = configuration
        
        setup()
    }
    
    private func setup() {
        switch configuration {
        case .console(let environmentName,
                      let severityLevel):
            
            setupConsoleLogger(environmentName: environmentName,
                               severityLevel: severityLevel)

        }
    }
    
 
    
    private func setupConsoleLogger(environmentName: String, severityLevel: SeverityLevel) {
        logTransporter = ConsoleTransporter(environmentName: environmentName,
                                            severityLevel: severityLevel)
    }
}

extension Logger: LoggerProtocol {
    public func debug(_ message: String, attributes: [String: String] = [:]) {
        logTransporter?.debug(message, attributes: attributes)
    }
    
    public func info(_ message: String, attributes: [String: String] = [:]) {
        logTransporter?.info(message, attributes: attributes)
    }
    
    public func notice(_ message: String, attributes: [String: String] = [:]) {
        logTransporter?.notice(message, attributes: attributes)
    }
    
    public func warning(_ message: String, attributes: [String: String] = [:]) {
        logTransporter?.warning(message, attributes: attributes)
    }
    
    public func error(message: String, attributes: [String: String] = [:]) {
        logTransporter?.error(message: message, attributes: attributes)
    }
    
    public func error(_ err: Error, attributes: [String: String] = [:]) {
        logTransporter?.error(err, attributes: attributes)
    }

    public func critical(_ message: String, attributes: [String: String] = [:]) {
        logTransporter?.critical(message, attributes: attributes)
    }
    
    public func addAttribute(key: GlobalAttribute, value: String) {
        logTransporter?.addAttribute(key: key, value: value)
    }
    
    public func removeAttribute(key: GlobalAttribute) {
        logTransporter?.removeAttribute(key: key)
    }
    
    public func set(severityLevel: SeverityLevel) {
        logTransporter?.set(severityLevel: severityLevel)
    }
    
    public func setUserInfo(id: String, name: String?, email: String?) {
        logTransporter?.setUserInfo(id: id, name: name, email: email)
    }
    
    public func removeUserInfo() {
        logTransporter?.removeUserInfo()
    }
}


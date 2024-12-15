//
//  LoggersAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation
import Infrastructure
import Swinject
import SwinjectAutoregistration

struct LoggersAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoggerProtocol.self, name: LoggerName.analytics) { _ in
            Logger(configuration: .console(environmentName: Environment.current.name, severityLevel: .debug))
        }
        container.register(LoggerProtocol.self, name: LoggerName.console) { _ in
            Logger(configuration: .console(environmentName: Environment.current.name, severityLevel: .debug))
        }

        container.register(LoggerProtocol.self, name: LoggerName.composer) { resolver in
            #if DEBUG
                LoggerComposer(loggers:
                    [resolver ~> (LoggerProtocol.self, name: LoggersAssembly.LoggerName.console)]
                )
            #else
                LoggerComposer(loggers:
                    [resolver ~> (LoggerProtocol.self, name: LoggersAssembly.LoggerName.datadog)]
                )
            #endif
        }
    }

    enum LoggerName {
        static let analytics = "analytics"
        static let console = "console"
        static let datadog = "datadog"
        static let composer = "composer"
    }
}

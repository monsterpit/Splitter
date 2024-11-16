//
//  LoggerAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation
import Infrastructure

enum LoggerAssembly {
    static let logger = Logger(configuration: .console(environmentName: Environment.current.name, severityLevel: .debug))
}

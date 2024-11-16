//
//  AnalyticsEnvironment+Environment.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

extension AnalyticsEnvironment {
    init(environment: Environment) {
        switch environment {
        case .prod:
            self = .prod
        case .uat:
            self = .uat
        case .dev:
            self = .dev
        }
    }
}

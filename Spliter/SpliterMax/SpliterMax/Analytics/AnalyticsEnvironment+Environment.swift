//
//  AnalyticsEnvironment+Environment.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation
import Services

extension AnalyticsEnvironment {
    init(environment: Environment) {
        switch environment {
        case .prod:
            self = .prod
        case .uat:
            self = .uat
        case .test:
            self = .test
        }
    }
}

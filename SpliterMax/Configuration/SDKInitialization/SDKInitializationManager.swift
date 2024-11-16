//
//  SDKInitializationManager.swift
//  LocalizationKit
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation
import UIKit

protocol SDKInitializableProtocol {
    func setup(logger: LoggerProtocol)
}

final class SDKInitializationManager {
    let sdkInitializables: [SDKInitializableProtocol]
    let options: [UIApplication.LaunchOptionsKey: Any]?

    init(sdkInitializables: [SDKInitializableProtocol], launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        self.sdkInitializables = sdkInitializables
        options = launchOptions
    }

    func setup(logger: LoggerProtocol) {
        sdkInitializables.forEach { $0.setup(logger: logger) }
    }
}

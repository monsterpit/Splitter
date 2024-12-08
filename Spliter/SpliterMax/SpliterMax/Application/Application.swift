//
//  Application.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import UIKit

final class Application {
    static let shared: Application = .init()

    let assembler: AppAssembler = .init()

    private var sdkManager: SDKInitializationManager {
        SDKInitializationManager(sdkInitializables: [
        ])
    }

    func launch(options _: [UIApplication.LaunchOptionsKey: Any]?) {
        assembler.appSessionService.didLaunch(appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
        sdkManager.setup(logger: assembler.logger)
        DesignSystem.configure(appState: assembler.coordinator.appState)
    }

    func connect(window _: UIWindow, with _: Set<NSUserActivity>?) {}

    func prepareScene() {
        assembler.coordinator.start()
    }
}

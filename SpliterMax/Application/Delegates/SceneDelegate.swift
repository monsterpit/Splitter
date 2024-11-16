//
//  SceneDelegate.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene), let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        self.window = window
        Application.shared.connect(window: window, with: connectionOptions.userActivities)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

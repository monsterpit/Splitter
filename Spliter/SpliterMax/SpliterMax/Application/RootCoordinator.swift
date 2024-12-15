//
//  RootCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine

import Infrastructure
import SharedCoreUI
import SwiftUI
import Utils

enum RootCoordinatorState {
    case launch, login(LoginState), main, jailBreak

    enum LoginState {
        case landing
    }
}

protocol RootCoordinatorProtocol: ParentCoordinatorProtocol {
    func changeState(_ state: RootCoordinatorState, animated: Bool)
}

final class RootCoordinator: ParentCoordinator {
    @Published private(set) var rootView: RootViewRepresentable?
    @Published private(set) var appState: AppState

//    private let authService: UserAuthenticationServiceAsyncProtocol

    private var cancellable: AnyCancellable?
    private let logger: LoggerProtocol?
    private let screenFactory: ScreenFactoryProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(appState: AppState,
         screenFactory: ScreenFactoryProtocol,
//         authService: UserAuthenticationServiceAsyncProtocol,
         logger: LoggerProtocol?)
    {
        self.appState = appState
        self.screenFactory = screenFactory
//        self.authService = authService
        self.logger = logger
        super.init(parentCoordinator: nil)
    }

    func start() {
        if JailBreakDetector.isJailBroken(logger: logger) {
            changeState(.jailBreak, animated: true)
        } else {
            changeState(.main, animated: true)
//            configureGlobalUserAttributes()

//            if authService.isAuthenticated {
//                // for authenticated session check user status for further navigation
//                changeState(.launch, animated: true)
//            } else {
//                // for unauthenticated session just show the login landing page
//                changeState(.login(.landing), animated: true)
//            }
        }
    }

//    private func configureGlobalUserAttributes() {
//        userService.localUser
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] localUser in
//                guard let self else { return }
//                guard let localUser, authService.isAuthenticated else { removeGlobalUserAttributes(); return }
//                logger?.addAttribute(key: .userId, value: localUser.id)
//                logger?.setUserInfo(id: localUser.id, name: localUser.fullName, email: localUser.emailAddress)
//            }
//            .store(in: &cancellables)
//        logger?.addAttribute(key: .appVersion, value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
//    }

//    private func removeGlobalUserAttributes() {
//        logger?.removeAttribute(key: .userId)
//        logger?.removeUserInfo()
//    }
}

extension RootCoordinator: RootCoordinatorProtocol {
    func changeState(_ state: RootCoordinatorState, animated _: Bool) {
        // cleanup existing coordinators because changing rootView is not observed in views hierarchy
        removeAllChildCoordinators()
        cancellable = nil

        var viewHolder: ViewControllerHolderProtocol?

        switch state {
        case .jailBreak:
            let config = ScreenConfiguration(coordinator: self as RootCoordinatorProtocol)
            screenFactory.assemble(.jailBreak, configuration: config).flatMap { view in
                viewHolder = view
            }
        case .launch:
            let config = ScreenConfiguration(coordinator: self as RootCoordinatorProtocol)
            screenFactory.assemble(.launch, configuration: config).flatMap { view in
                viewHolder = view
            }
        case let .login(state):
            let signupState = switch state {
            case .landing:
                SignUpStartRoute.login
            }
            viewHolder = SignupFlowCoordinator(parentCoordinator: self).start(route: signupState)
        case .main:
            let config = MainScreenConfiguration(coordinator: self)
            screenFactory.assemble(.main, configuration: config).flatMap { view in
                let navigationController = BaseNavigationController(rootViewController: view)
                navigationController.navigationBar.applyStyle(.default)
                navigationController.setNavigationBarHidden(true, animated: false)
                viewHolder = navigationController
            }
            // observe logout
            //            cancellable = authService.isAuthenticatedPublisher
            //                .dropFirst()
            //                .filter { !$0 }
            //                .receive(on: DispatchQueue.main)
            //                .sink { [weak self] _ in
            //                    guard let self else { return }
            //                    changeState(.login(.landing), animated: true)
            //                }
        }
        self.viewHolder = viewHolder
        guard let viewController = viewHolder?.viewController else {
            assertionFailure("view holder is missing on change state")
            return
        }
        if rootView != nil {
            // workaround to let the app view finish all current updates and only then update to another view
            // otherwise, in some cases, previous view may remain in the view hierarchy causing unexpected issues
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.rootView = RootViewRepresentable(viewController: viewController)
            }
        } else {
            rootView = RootViewRepresentable(viewController: viewController)
        }
    }
}

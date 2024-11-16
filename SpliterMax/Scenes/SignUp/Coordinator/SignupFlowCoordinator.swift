//
//  SignupFlowCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
import UIKit

enum SignUpStartRoute {
    case login, userDetails(SignUpType)
}

enum SignUpFlow: Equatable {
    case initial, login, createAccount, success, locked(title: String)
}

final class SignupFlowCoordinator: ParentCoordinator {
    private var rootCoordinator: RootCoordinatorProtocol?

    init(parentCoordinator: RootCoordinatorProtocol?) {
        rootCoordinator = parentCoordinator
        super.init(parentCoordinator: parentCoordinator, autoRemove: false)
    }

    // TODO: Vikas handle login flow
    func start(route: SignUpStartRoute) -> UIViewController? {
        let config = ScreenConfiguration(coordinator: self)

        let navigationController: BaseNavigationController? = nil
        viewHolder = navigationController

        switch route {
        case .login:
            break
        case let .userDetails(signupType):
            break
        }

        return navigationController
    }
}

extension ScreenName {
    static var login: Self { .selfName() }
}

//
//  LaunchViewModel.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

protocol LaunchNavigationProtocol {
    func change(state: RootCoordinatorState)
}

protocol LaunchViewModelProtocol: ObservableObject {
    func onAppear()
}

final class LaunchViewModel {
    private let coordinator: LaunchNavigationProtocol
    private let userService: UserServiceAsyncProtocol

    init(coordinator: LaunchNavigationProtocol, userService: UserServiceAsyncProtocol) {
        self.coordinator = coordinator
        self.userService = userService
    }

    private func signupType(for user: User) -> SignUpType? {
        if let email = user.emailAddress, !email.isEmpty {
            .email(email: email)
        } else if let phone = user.phone, !phone.isEmpty {
            .phoneNumber(phoneNumber: phone)
        } else {
            nil
        }
    }

    private func navigate(user _: User) {
        coordinator.change(state: .login(.landing))
    }
}

extension LaunchViewModel: LaunchViewModelProtocol {
    func onAppear() {
        coordinator.change(state: .login(.landing))
    }
}

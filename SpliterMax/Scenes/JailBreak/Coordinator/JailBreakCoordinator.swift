//
//  JailBreakCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

final class JailBreakCoordinator: ParentCoordinator {
    private let rootCoordinator: RootCoordinatorProtocol

    init(rootCoordinator: RootCoordinatorProtocol) {
        self.rootCoordinator = rootCoordinator
        super.init(parentCoordinator: rootCoordinator)
    }
}

extension JailBreakCoordinator: JailBreakViewNavigationProtocol {
    func change(state: RootCoordinatorState) {
        rootCoordinator.changeState(state, animated: true)
    }
}

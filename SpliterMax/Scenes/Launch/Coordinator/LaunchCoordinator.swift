//
//  LaunchCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

final class LaunchCoordinator: ParentCoordinator {
    private let rootCoordinator: RootCoordinatorProtocol
    
    init(rootCoordinator: RootCoordinatorProtocol) {
        self.rootCoordinator = rootCoordinator
        super.init(parentCoordinator: rootCoordinator)
    }
}

extension LaunchCoordinator: LaunchNavigationProtocol {
    func change(state: RootCoordinatorState) {
        rootCoordinator.changeState(state, animated: true)
    }
}

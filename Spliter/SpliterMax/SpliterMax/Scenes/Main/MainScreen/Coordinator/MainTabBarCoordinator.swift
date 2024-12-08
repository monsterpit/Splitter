//
//  MainTabBarCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import UIKit

enum MainTab: Int {
    case explore, trips, wallet, profile
    
    var index: Int {
        rawValue
    }
}

protocol MainTabCoordinatorProtocol {
    var tab: MainTab { get }
    
    func handle(activity: MainTabActivity)
}

enum MainTabActivity {

}

protocol MainTabBarCoordinatorProtocol: ParentCoordinatorProtocol {
    func addTabCoordinator(_ coordinator: MainTabCoordinatorProtocol)
    func navigateToTab(_ tab: MainTab, with activity: MainTabActivity?)
}

final class MainTabBarCoordinator: ParentCoordinator {
    private var tabCoordinators: [MainTab: MainTabCoordinatorProtocol] = [:]
    
    private var tabbarController: UITabBarController? {
        viewHolder as? UITabBarController
    }
    
    init(parentCoordinator: RootCoordinatorProtocol?) {
        super.init(parentCoordinator: parentCoordinator)
    }
}

extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    func addTabCoordinator(_ coordinator: any MainTabCoordinatorProtocol) {
        tabCoordinators[coordinator.tab] = coordinator
    }
    
    func navigateToTab(_ tab: MainTab, with activity: MainTabActivity?) {
        if let viewController = tabbarController?.viewControllers?[safe: tab.index] {
            tabbarController?.selectedViewController = viewController
            if let activity {
                tabCoordinators[tab]?.handle(activity: activity)
            }
        }
    }
}

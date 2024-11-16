//
//  BaseTabBarController.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import UIKit

open class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    public func setTabViews(_ views: [TabViewProtocol]) {
        let viewControllers = views.map {
            let viewController = $0.viewController
            viewController.tabBarItem = $0.tabBarItem
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5.5, left: 5.5, bottom: 5.5, right: 5.5)
            return viewController
        }
        self.viewControllers = viewControllers
        Task { @MainActor in
            if let viewController = self.selectedViewController {
                self.didSelect(viewController: viewController)
            }
        }
    }
    
    override open var selectedViewController: UIViewController? {
        didSet {
            if let selectedViewController {
                didSelect(viewController: selectedViewController)
            }
        }
    }
    
    open func didSelect(viewController: UIViewController) {
        // override
    }
    
    // MARK: - UITabBarControllerDelegate

    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        didSelect(viewController: viewController)
    }
}


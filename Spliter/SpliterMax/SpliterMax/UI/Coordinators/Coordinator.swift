//
//  Coordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import SharedCoreUI
import UIKit

/// Navigation type to use when presenting view controllers
public enum CoordinatorNavigation {
    /// Use navigation controller
    case push
    /// Use modal presentation
    case modal
    /// Use modal presentation with full screen presentation style
    case fullScreenModal
    /// Use modal presentation with overCurrentContext modalPresentationStyle and transparent background color
    case modalTransparent
}

public protocol DismissableCoordinatorProtocol: AnyObject {
    /// Called when the view controller is about to close
    ///
    /// Typically called from viewcontroller's viewWillDisappear method
    func viewWillClose()

    /// Called when the view controller is closed
    ///
    /// Typically called from viewcontroller's viewDidDisappear method
    func viewDidClose()
}

public extension DismissableCoordinatorProtocol {
    func viewWillClose() {}

    func viewDidClose() {}
}

// sourcery: AutoMockable
public protocol CoordinatorProtocol: DismissableCoordinatorProtocol {
    /// The view controller holder for the coordinator
    ///
    ///  Should be stored as weak reference to avoid retain cycles between view controller and coordinator's owner
    var viewHolder: ViewControllerHolderProtocol? { get set }

    /// Navigates to the view according to navigation type
    ///
    /// - Parameters:
    ///   - type: navigation type:
    ///   - view: UIViewController to present
    ///   - animated: whether to apply system animation
    ///   - completion: closure to call on animation completion. Note: for push navigation the completion will be called immediately after push method
    func navigate(_ type: CoordinatorNavigation, view: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Closes the presented view controller according to the navigation type
    /// - Parameters:
    ///   - type: navigation type
    ///   - animated: whether to apply system animation
    ///   - completion: closure to call on animation completion. Note: for push navigation the completion will be called immediately after pop method
    func close(_ type: CoordinatorNavigation, animated: Bool, completion: (() -> Void)?)

    /// Closes the presented view
    /// - Parameter animated: whether to apply system animation
    ///
    ///  The navigation type is inferred automatically by checking view controller's navigation and presenting view controllers
    func close(animated: Bool)

    /// Pop to root view controller in the current navigation controller
    /// - Parameter animated: whether to apply system animation
    ///
    ///  If the current view controller doesn't have navigation controller this method does nothing
    func popToRoot(animated: Bool)
}

public extension CoordinatorProtocol {
    var viewController: UIViewController? {
        viewHolder?.viewController
    }

    var navigationController: UINavigationController? {
        if let viewController = viewController as? UINavigationController {
            return viewController
        }
        return viewController?.navigationController
    }

    var visibleViewController: UIViewController? {
        if let navigationController {
            navigationController.visibleViewController
        } else {
            viewController?.presentedViewController ?? viewController
        }
    }

    func navigate(_ type: CoordinatorNavigation, view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        switch type {
        case .push:
            navigationController?.pushViewController(view, animated: animated)
            completion?()
        case .modal:
            visibleViewController?.present(view, animated: animated, completion: completion)
        case .fullScreenModal:
            view.modalPresentationStyle = .fullScreen
            visibleViewController?.present(view, animated: animated, completion: completion)
        case .modalTransparent:
            view.modalPresentationStyle = .overCurrentContext
            view.view.backgroundColor = .clear
            visibleViewController?.present(view, animated: animated, completion: completion)
        }
    }

    func close(_ type: CoordinatorNavigation, animated: Bool, completion: (() -> Void)?) {
        switch type {
        case .push:
            navigationController?.popViewController(animated: animated)
            completion?()
        case .modal, .modalTransparent, .fullScreenModal:
            viewController?.dismiss(animated: animated, completion: completion)
        }
    }

    func close(animated: Bool) {
        guard let viewController else {
            return
        }
        let navigation: CoordinatorNavigation = viewController.isModal ? .modal : .push
        close(navigation, animated: animated, completion: nil)
    }

    func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func popToViewController(viewController: UIViewController) {
        navigationController?.popToViewController(viewController, animated: true)
    }

    // MARK: - Convenient methods

    func present(view: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigate(.modal, view: view, animated: animated, completion: completion)
    }

    func presentModalSheet(view: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        navigate(.modalTransparent, view: view, animated: animated, completion: completion)
    }

    func push(view: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigate(.push, view: view, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        close(.modal, animated: animated, completion: completion)
    }

    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        close(.push, animated: animated, completion: completion)
    }
}

private extension UIViewController {
    var isModal: Bool {
        if navigationController != nil, navigationController?.viewControllers.first != self {
            false
        } else {
            presentingViewController != nil || navigationController?.presentingViewController?.presentedViewController == navigationController
        }
    }
}

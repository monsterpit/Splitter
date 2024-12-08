//
//  ParentCoordinator.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import UIKit

/// All the top-level coordinators should conform to this protocol
// sourcery: AutoMockable
public protocol ParentCoordinatorProtocol: CoordinatorProtocol {
    var parentCoordinator: ParentCoordinatorProtocol? { get }
    var coordinators: [CoordinatorProtocol] { get }

    /// Appends the coordinator to the children array.
    ///
    /// - Parameter child: The child coordinator to be appended to the list.
    /// - Parameter autoRemove: Whether to remove the child from its parent when it's deallocated or not.
    func addChild(_ child: CoordinatorProtocol, autoRemove: Bool)

    /// Removes the child from children array.
    ///
    /// - Parameter child: The child coordinator to be removed from the list.
    func childDidFinish(_ child: CoordinatorProtocol)
}

open class ParentCoordinator: ParentCoordinatorProtocol {
    public weak var parentCoordinator: ParentCoordinatorProtocol?
    public weak var viewHolder: ViewControllerHolderProtocol?

    public var coordinators: [CoordinatorProtocol] {
        childCoordinators.existingCoordinators()
    }

    private var childCoordinators: [WrappedCoordinator] = []

    /// Creates coordinator and adds it to the given parentCoordinator's childCoordinators
    ///
    /// - Parameter parentCoordinator: The parent coordinator to be associated with.
    /// - Parameter autoRemove: Whether to remove the coordinator from its parent when it's deallocated or not. By default true.
    ///
    ///  If autoRemove is true the coordinator will be added as a weak reference to its parrent and be removed automatically when its view is no longer present and deallocated
    ///
    ///  If autoRemove is false the parent coordinator will hold strong reference on the coordinator and it will be this coordinator responsibility to remove it from the parrent by calling childDidFinish on the parent coordinator.
    public init(parentCoordinator: ParentCoordinatorProtocol?, autoRemove: Bool = true) {
        self.parentCoordinator = parentCoordinator
        parentCoordinator?.addChild(self, autoRemove: autoRemove)
    }

    public func viewDidClose() {
        parentCoordinator?.childDidFinish(self)
    }

    open func addChild(_ child: CoordinatorProtocol, autoRemove: Bool) {
        if autoRemove {
            childCoordinators.append(.weak(.init(value: child)))
        } else {
            childCoordinators.append(.strong(child))
        }
    }

    open func childDidFinish(_ child: CoordinatorProtocol) {
        childCoordinators.prune()
        if let coordinatorIndex = childCoordinators.firstIndex(where: { $0.coordinator === child }) {
            childCoordinators.remove(at: coordinatorIndex)
        }
    }

    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    public func findCoordinator<Coordinator>() -> Coordinator? {
        coordinators.first { $0 is Coordinator } as? Coordinator
    }
}

enum WrappedCoordinator {
    case weak(AnyWeakCoordinator)
    case strong(CoordinatorProtocol)

    var coordinator: CoordinatorProtocol? {
        switch self {
        case let .weak(anyWeakCoordinator):
            anyWeakCoordinator.value
        case let .strong(coordinatorProtocol):
            coordinatorProtocol
        }
    }
}

struct AnyWeakCoordinator {
    weak var value: CoordinatorProtocol?
}

extension [WrappedCoordinator] {
    func existingCoordinators() -> [CoordinatorProtocol] {
        compactMap(\.coordinator)
    }

    mutating func prune() {
        self = filter { $0.coordinator != nil }
    }
}

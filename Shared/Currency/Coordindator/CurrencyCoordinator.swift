//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import SharedCoreUI
import Utils

public enum CurrencyStartRoute {
    case root
}

public protocol CurrencyExternalNavigationProtocol: ParentCoordinatorProtocol {}

public protocol CurrencyCoordinatorProtocol {
    func start(route: CurrencyStartRoute) -> any ViewControllableProtocol
}

final class CurrencyCoordinator: ParentCoordinator {
    private let screenFactory: CurrencyScreenFactoryProtocol
    private weak var externalNavigationCoordinator: CurrencyExternalNavigationProtocol?

    init(parentCoordinator: CurrencyExternalNavigationProtocol?,
         screenFactory: CurrencyScreenFactoryProtocol)
    {
        self.screenFactory = screenFactory
        externalNavigationCoordinator = parentCoordinator
        super.init(parentCoordinator: parentCoordinator)
    }
}

extension CurrencyCoordinator: CurrencyCoordinatorProtocol {
    func start(route: CurrencyStartRoute) -> any ViewControllableProtocol {
        let view: any ViewControllableProtocol = switch route {
        case .root:
            screenFactory.makeScreen(.main(coordinator: self))
        }
        viewHolder = view.holder
        return view
    }
}

extension CurrencyCoordinator: CurrencyViewNavigationProtocol {}

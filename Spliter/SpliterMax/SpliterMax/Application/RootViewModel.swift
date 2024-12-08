//
//  RootViewModel.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine
import Foundation
import Utils

final class RootViewModel: ObservableObject {
    @Published var rootView: RootViewRepresentable?
    @Published var showActivityIndicator = false

    var appState: AppState {
        coordinator.appState
    }

    private let coordinator: RootCoordinator

    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator

        coordinator.$rootView.assign(to: &$rootView)
        coordinator.appState.$showActivityIndicator.assign(to: &$showActivityIndicator)
    }
}

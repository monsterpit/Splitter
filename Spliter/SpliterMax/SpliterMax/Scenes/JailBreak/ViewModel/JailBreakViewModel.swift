//
//  JailBreakViewModel.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
import LocalizationKit
import SharedCoreUI

protocol JailBreakViewNavigationProtocol {}

protocol JailBreakViewModelProtocol: LoadableViewModelProtocol {
    func onAppear()
}

final class JailBreakViewModel: LoadableViewModel {
    private let coordinator: JailBreakViewNavigationProtocol

    init(coordinator: JailBreakViewNavigationProtocol) {
        self.coordinator = coordinator
    }
}

extension JailBreakViewModel: JailBreakViewModelProtocol {
    func onAppear() {
        let message = SystemMessage(title: StringConstants.JailBreak.alertTitle,
                                    body: StringConstants.JailBreak.alertDesc,
                                    primaryAction: .init(title: StringConstants.ok, action: {}))
        showAlert(message: message)
    }
}

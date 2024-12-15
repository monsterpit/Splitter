//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import Foundation
import Infrastructure
import SharedCoreUI
import Utils

protocol CurrencyViewNavigationProtocol: AnyObject {}

public protocol CurrencyViewModelProtocol: LoadableViewModelProtocol {}

final class CurrencyViewModel: LoadableViewModel {
    private let coordinator: CurrencyViewNavigationProtocol
    private let logger: LoggerProtocol?

    init(coordinator: CurrencyViewNavigationProtocol,
         logger: LoggerProtocol?)
    {
        self.coordinator = coordinator
        self.logger = logger
        super.init()
    }
}

extension CurrencyViewModel: CurrencyViewModelProtocol {}

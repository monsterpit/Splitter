//
// Copyright (c) 2025-present Vikas Salian. All Rights Reserved.
//

import SharedCoreUI
import SwiftUI
import Utils

public struct CurrencyView<ViewModel: CurrencyViewModelProtocol>: ViewControllableProtocol {
    public var holder: ViewControllerHolder = .init()

    @StateObject var viewModel: ViewModel

    public var body: some View {
        Text("wow")
    }
}

//
//  JailBreakView.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//
import LocalizationKit
import SharedCoreUI
import SwiftUI

struct JailBreakView<ViewModel: JailBreakViewModelProtocol>: View, ViewControllableProtocol {
    var holder: ViewControllerHolder = .init()
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text(StringConstants.JailBreak.alertDesc)
                .padding()
        }
        .loadable(viewModel: viewModel)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

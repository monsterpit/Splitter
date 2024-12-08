//
//  LaunchView.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SharedCoreUI
import SwiftUI
import Utils

struct LaunchView<ViewModel: LaunchViewModelProtocol>: View, ViewControllableProtocol {
    var holder: ViewControllerHolder = .init()

    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.red
            Image(systemName: "arrow.down.circle")
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

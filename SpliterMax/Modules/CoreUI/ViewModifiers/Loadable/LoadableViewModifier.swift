//
//  LoadableViewModifier.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public struct LoadableViewModifier<ViewModel: LoadableViewModelProtocol>: ViewModifier {
    @StateObject var viewModel: ViewModel

    public func body(content: Content) -> some View {
        ZStack {
            content
            // prevent resetting content view to default state
            VStack {}
                .showAlert(when: $viewModel.alertIsPresented, message: viewModel.alertMessage)
                .showInfoToast(isPresented: $viewModel.isToastPresented,
                               message: viewModel.toastMessage,
                               viewType: viewModel.toastType)
                .showNoInternetToast(isPresented: $viewModel.globalNoInternetPopupIsPresented) {
                    UserInterfaceConfiguration.appState?.showNoInternetPopup = false
                }
        }
        .onChange(of: viewModel.showActivityIndicator) { showActivityIndicator in
            UserInterfaceConfiguration.appState?.showActivityIndicator = showActivityIndicator
        }
        .onDisappear {
            if viewModel.showActivityIndicator {
                UserInterfaceConfiguration.appState?.showActivityIndicator = false
                viewModel.showActivityIndicator = false
            }
        }
    }
}

public extension View {
    func loadable(viewModel: some LoadableViewModelProtocol) -> some View {
        modifier(LoadableViewModifier(viewModel: viewModel))
    }
}

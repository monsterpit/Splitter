//
//  LoadableViewModel.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Combine
import Foundation

public protocol LoadableViewModelProtocol: ObservableObject {
    var alertIsPresented: Bool { get set }
    var alertMessage: SystemMessage? { get }
    var showActivityIndicator: Bool { get set }

    var toastMessage: ToastMessage? { get }
    var toastType: ToastViewType { get }
    var isToastPresented: Bool { get set }
    var globalNoInternetPopupIsPresented: Bool { get set }
}

open class LoadableViewModel: LoadableViewModelProtocol {
    @Published public var globalNoInternetPopupIsPresented = false
    @Published public var alertIsPresented = false {
        didSet {
            if !alertIsPresented {
                alertMessage = nil
            }
        }
    }

    @Published public var showActivityIndicator = false

    @Published public var isToastPresented = false {
        didSet {
            if !isToastPresented {
                toastMessage = nil
            }
        }
    }

    public private(set) var alertMessage: SystemMessage?
    public private(set) var toastMessage: ToastMessage?
    public private(set) var toastType: ToastViewType = [.compact, .closable]

    private var loadingsCount = 0
    private var cancellables: Set<AnyCancellable> = []

    public init() {
        UserInterfaceConfiguration.appState?.$showNoInternetPopup
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { showNoInternet in
                self.globalNoInternetPopupIsPresented = showNoInternet
            })
            .store(in: &cancellables)
    }

    public func showToast(message: ToastMessage, type: ToastViewType = [.compact, .closable]) {
        toastType = type
        toastMessage = message
        isToastPresented = true
    }

    public func showAlert(message: SystemMessage) {
        alertMessage = message
        alertIsPresented = true
    }

    public func showAlert(message: String) {
        alertMessage = .init(title: message, primaryAction: .okAction())
        alertIsPresented = true
    }

    public func showErrorToast(error: Error, type: ToastViewType = [.compact]) {
        if let error = error as? ApiError {
            showToast(message: ToastMessage(text: getDisplayErrorMessage(error: error), image: ImageSet.Help.Info.warning.toImage()),
                      type: type)
        } else {
            showToast(message: ToastMessage(text: "something went wrong", image: ImageSet.Help.Info.warning.toImage()),
                      type: type)
        }
        isToastPresented = true
    }

    public func showErrorToast(message: String, type: ToastViewType = [.compact]) {
        showToast(message: ToastMessage(text: message, image: ImageSet.Help.Info.warning.toImage()),
                  type: type)
        isToastPresented = true
    }

    public func showAlert(error: Error) {
        if let error = error as? ApiError {
            switch error {
            case .noInternet:
                UserInterfaceConfiguration.appState?.showNoInternetPopup = true
            default: // Displaying bottom global popup instead
                showAlert(message: getDisplayErrorMessage(error: error))
            }
        } else {
            showAlert(message: "something went wrong")
        }
    }

    private func getDisplayErrorMessage(error: ApiError) -> String {
        switch error {
        case let .signInFailed(message):
            message ?? ""
        default:
            "something went wrong"
        }
    }

    public func showLoading(incremental: Bool = false) {
        if incremental {
            loadingsCount += 1
        }
        showActivityIndicator = true
    }

    public func hideLoading(incremental: Bool = false) {
        if incremental {
            loadingsCount = max(0, loadingsCount - 1)
            if loadingsCount == 0 {
                showActivityIndicator = false
            }
        } else {
            showActivityIndicator = false
        }
    }
}

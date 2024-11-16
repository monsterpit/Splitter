//
//  ToastViewModifier.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool

    let message: ToastMessage
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let imageColor: Color
    let textColor: Color
    let closeButtonColor: Color
    let borderColor: Color
    let backgroundColor: Color
    let toastVisiblityDuration: Double
    var exitEventHandler: (() -> Void)?
    var retryEventHandler: (() -> Void)?
    var viewType: ToastViewType = [.compact]
    var hasDynamicWidth: Bool
    var fontStyle: FontSet.TextStyle
    var fontWeight: FontSet.Weight

    @State private var opacity = 0.0
    @State private var hideWorkItem: DispatchWorkItem?

    var toastView: ToastView {
        ToastView(message: message,
                  imageWidth: imageWidth,
                  imageHeight: imageHeight,
                  imageColor: imageColor,
                  textColor: textColor,
                  closeButtonColor: closeButtonColor,
                  borderColor: borderColor,
                  backgroundColor: backgroundColor,
                  exitEventHandler: handleExitPress,
                  retryEventHandler: handleRetryPress,
                  viewType: viewType,
                  hasDynamicWidth: hasDynamicWidth,
                  fontStyle: fontStyle,
                  fontWeight: fontWeight)
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                if viewType.contains(.persistent) {
                    toastView
                        .opacity(opacity)
                        .onChange(of: isPresented) { _ in
                            showToastView()
                        }
                        .onAppear {
                            showToastView()
                        }
                } else {
                    toastView
                        .opacity(opacity)
                        .onChange(of: isPresented) { _ in
                            toggleToastViewVisibleState()
                        }
                        .onAppear {
                            toggleToastViewVisibleState()
                        }
                }
            }
        }
    }

    private func toggleToastViewVisibleState() {
        if isPresented {
            showToastView()
            hideToastView()
        } else {
            hideToastView()
        }
    }

    private func showToastView() {
        withAnimation(Animation.easeInOut(duration: Constants.duration)) {
            opacity = Constants.maxOpacity
        }
    }

    private func hideToastView(withDelay: Bool = true) {
        hideWorkItem?.cancel()
        hideWorkItem = DispatchWorkItem {
            withAnimation(Animation.easeInOut(duration: Constants.duration)) {
                opacity = Constants.minOpacity
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.duration) {
                if isPresented {
                    isPresented = false
                    hideWorkItem = nil
                }
            }
        }
        guard let hideWorkItem else { return }
        let delay = withDelay ? toastVisiblityDuration : 0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: hideWorkItem)
    }

    func handleExitPress() {
        if let exitEventHandler {
            exitEventHandler()
        } else {
            hideToastView(withDelay: false)
        }
    }

    func handleRetryPress() {
        retryEventHandler?()
    }
}

extension ToastViewModifier {
    private enum Constants {
        static let minOpacity: Double = 0
        static let maxOpacity: Double = 1
        static let duration = 0.5
    }
}

public extension View {
    func showToast(isPresented: Binding<Bool>,
                   message: ToastMessage,
                   imageWidth: CGFloat,
                   imageHeight: CGFloat,
                   imageColor: Color,
                   textColor: Color,
                   borderColor: Color,
                   backgroundColor: Color,
                   closeButtonColor: Color? = nil,
                   toastVisiblityDuration: Double = 4,
                   exitEventHandler: (() -> Void)? = nil,
                   retryEventHandler: (() -> Void)? = nil,
                   viewType: ToastViewType = [.compact],
                   hasDynamicWidth: Bool = true,
                   fontStyle: FontSet.TextStyle = .bodyMd,
                   fontWeight: FontSet.Weight = .semibold) -> some View
    {
        modifier(ToastViewModifier(isPresented: isPresented,
                                   message: message,
                                   imageWidth: imageWidth,
                                   imageHeight: imageHeight,
                                   imageColor: imageColor,
                                   textColor: textColor,
                                   closeButtonColor: closeButtonColor ?? textColor,
                                   borderColor: borderColor,
                                   backgroundColor: backgroundColor,
                                   toastVisiblityDuration: toastVisiblityDuration,
                                   exitEventHandler: exitEventHandler,
                                   retryEventHandler: retryEventHandler,
                                   viewType: viewType,
                                   hasDynamicWidth: hasDynamicWidth,
                                   fontStyle: fontStyle,
                                   fontWeight: fontWeight))
    }
}

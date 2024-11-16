//
//  AlertModifier.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import LocalizationKit
import SwiftUI

public struct SystemMessage {
    public struct Action {
        public enum ActionType {
            case `default`, cancel, destructive
        }

        let title: String
        let actionType: ActionType
        let action: () -> Void

        public init(title: String, type: ActionType = .default, action: @escaping () -> Void) {
            self.title = title
            actionType = type
            self.action = action
        }

        public static func okAction(action: (() -> Void)? = nil) -> Self {
            .init(title: StringConstants.ok, type: .default, action: { action?() })
        }

        public static func cancelAction() -> Self {
            .init(title: StringConstants.cancel, type: .default, action: {})
        }
    }

    let title: String
    let body: String?
    let primaryAction: Action
    let secondaryAction: Action?

    public init(title: String, body: String? = nil, primaryAction: Action, secondaryAction: Action? = nil) {
        self.title = title
        self.body = body
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

public struct AlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: SystemMessage

    public func body(content: Content) -> some View {
        content.alert(isPresented: $isPresented) {
            if let secondaryAction = message.secondaryAction {
                Alert(title: Text(message.title),
                      message: message.body.flatMap { Text($0) },
                      primaryButton: message.primaryAction.button,
                      secondaryButton: secondaryAction.button)
            } else {
                Alert(title: Text(message.title),
                      message: message.body.flatMap { Text($0) },
                      dismissButton: message.primaryAction.button)
            }
        }
    }
}

public extension View {
    @ViewBuilder
    func showAlert(when isPresented: Binding<Bool>, message: SystemMessage?) -> some View {
        if let message {
            modifier(AlertModifier(isPresented: isPresented, message: message))
        } else {
            modifier(EmptyModifier())
        }
    }
}

private extension SystemMessage.Action {
    var button: Alert.Button {
        switch actionType {
        case .default:
            .default(Text(title), action: action)
        case .cancel:
            .cancel(Text(title), action: action)
        case .destructive:
            .destructive(Text(title), action: action)
        }
    }
}

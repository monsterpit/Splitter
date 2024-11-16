//
//  ActionButtonStyle.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
    public enum Style {
        case primary, secondary, tertiary
    }

    public enum Size {
        case medium, large
    }

    let size: Size
    let config: ActionButtonConfiguration
    let leftImage: UIImage?
    let rightImage: UIImage?

    public init(style: Style, size: Size = .medium, leftImage: UIImage? = nil, rightImage: UIImage? = nil) {
        self.size = size
        config = style.configuration
        self.leftImage = leftImage
        self.rightImage = rightImage
    }

    public func makeBody(configuration: Configuration) -> some View {
        ButtonStyleContent { isEnabled in
            configuration.label
                .actionButton(attributes: Attributes(size: size, isEnabled: isEnabled, isPressed: configuration.isPressed, config: config),
                              leftImage: leftImage,
                              rightImage: rightImage)
                .background(config.backgroundColor.color(isEnabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(config.cornerRadius)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .overlay(
                    config.border.flatMap { overlay(config: $0, isEnabled: isEnabled, isPressed: configuration.isPressed) }
                )
        }
    }

    private func overlay(config: ActionButtonConfiguration.BorderConfiguration, isEnabled: Bool, isPressed: Bool) -> some View {
        RoundedRectangle(cornerRadius: self.config.cornerRadius)
            .stroke(config.color.color(isEnabled: isEnabled, isPressed: isPressed),
                    lineWidth: config.lineWidth)
            .padding(config.lineWidth)
    }
}

extension ActionButtonStyle {
    struct Attributes: ActionButtonModifierAttributesProtocol {
        let size: Size
        let isEnabled: Bool
        let isPressed: Bool
        let config: ActionButtonConfiguration

        var textColor: Color {
            config.textColor.color(isEnabled: isEnabled, isPressed: isPressed)
        }

        var iconColor: Color {
            config.iconColor.color(isEnabled: isEnabled, isPressed: isPressed)
        }

        var spacing: CGFloat {
            size == .medium ? 8 : 10
        }

        var horizontalPadding: CGFloat {
            size == .medium ? 12 : 16
        }

        var height: CGFloat {
            size == .medium ? 44 : 52
        }

        var fontStyle: FontSet.Style {
            (style: size == .medium ? .buttonMd : .buttonLg, weight: .semibold)
        }
    }
}

//
//  ActionButtonConfiguration.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import UIKit

public struct ActionButtonConfiguration {
    let textColor: ColorConfiguration
    let iconColor: ColorConfiguration
    let backgroundColor: ColorConfiguration
    let cornerRadius: CGFloat
    let border: BorderConfiguration?

    public init(textColor: ColorConfiguration,
                iconColor: ColorConfiguration,
                backgroundColor: ColorConfiguration,
                cornerRadius: CGFloat,
                border: BorderConfiguration? = nil)
    {
        self.textColor = textColor
        self.iconColor = iconColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.border = border
    }
}

public extension ActionButtonConfiguration {
    struct ColorConfiguration {
        let normal: ColorConvertibleProtocol
        let pressed: ColorConvertibleProtocol
        let disabled: ColorConvertibleProtocol

        public init(normal: ColorConvertibleProtocol, pressed: ColorConvertibleProtocol, disabled: ColorConvertibleProtocol) {
            self.normal = normal
            self.pressed = pressed
            self.disabled = disabled
        }
    }

    struct BorderConfiguration {
        let lineWidth: CGFloat
        let color: ColorConfiguration

        public init(lineWidth: CGFloat, color: ColorConfiguration) {
            self.lineWidth = lineWidth
            self.color = color
        }
    }
}

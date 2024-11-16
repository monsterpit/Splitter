//
//  ActionButtonStyle+Config.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation

extension ActionButtonStyle.Style {
    var configuration: ActionButtonConfiguration {
        switch self {
        case .primary:
            return .init(textColor: .init(normal: ColorSet.Buttons.Primary.text,
                                          pressed: ColorSet.Buttons.Primary.text,
                                          disabled: ColorSet.Buttons.Primary.textDisabled),
                         iconColor: .init(normal: ColorSet.Buttons.Primary.text,
                                          pressed: ColorSet.Buttons.Primary.text,
                                          disabled: ColorSet.Buttons.Primary.textDisabled),
                         backgroundColor: .init(normal: ColorSet.Buttons.Primary.background,
                                                pressed: ColorSet.Buttons.Primary.backgroundPressed,
                                                disabled: ColorSet.Buttons.Primary.backgroundDisabled),
                         cornerRadius: GeometrySet.buttonCornerRadius.constant)
        case .secondary:
            return .init(textColor: .init(normal: ColorSet.Buttons.Secondary.text,
                                          pressed: ColorSet.Buttons.Secondary.text,
                                          disabled: ColorSet.Buttons.Secondary.disabled),
                         iconColor: .init(normal: ColorSet.Buttons.Secondary.text,
                                          pressed: ColorSet.Buttons.Secondary.text,
                                          disabled: ColorSet.Buttons.Secondary.disabled),
                         backgroundColor: .init(normal: ColorConvertible.clear,
                                                pressed: ColorConvertible.clear,
                                                disabled: ColorConvertible.clear),
                         cornerRadius: GeometrySet.buttonCornerRadius.constant,
                         border: .init(lineWidth: 2,
                                       color: .init(normal: ColorSet.Buttons.Secondary.stroke,
                                                    pressed: ColorSet.Buttons.Secondary.strokePressed,
                                                    disabled: ColorSet.Buttons.Secondary.disabled)))
        case .tertiary:
            return .init(textColor: .init(normal: ColorSet.Buttons.Tertiary.text,
                                          pressed: ColorSet.Buttons.Tertiary.text,
                                          disabled: ColorSet.Buttons.Tertiary.textDisabled),
                         iconColor: .init(normal: ColorSet.Buttons.Tertiary.icon,
                                          pressed: ColorSet.Buttons.Tertiary.icon,
                                          disabled: ColorSet.Buttons.Tertiary.textDisabled),
                         backgroundColor: .init(normal: ColorSet.Buttons.Tertiary.background,
                                                pressed: ColorSet.Buttons.Tertiary.backgroundPressed,
                                                disabled: ColorSet.Buttons.Tertiary.backgroundDisabled),
                         cornerRadius: GeometrySet.buttonCornerRadius.constant)
        }
    }
}

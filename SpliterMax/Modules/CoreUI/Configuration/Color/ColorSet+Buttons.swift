//
//  ColorSet+Buttons.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation

public extension ColorSet {
    enum Buttons {
        case primary(Primary)
        case secondary(Secondary)
        case tertiary(Tertiary)
        case textLink(TextLink)

        public enum Primary: ColorSetConvertibleProtocol {
            case background
            case backgroundPressed
            case backgroundDisabled
            case text
            case textDisabled

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Buttons.primary(self))
            }
        }

        public enum Secondary: ColorSetConvertibleProtocol {
            case stroke
            case strokePressed
            case text
            case icon
            case disabled

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Buttons.secondary(self))
            }
        }

        public enum Tertiary: ColorSetConvertibleProtocol {
            case background
            case backgroundDisabled
            case backgroundPressed
            case icon
            case text
            case textDisabled

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Buttons.tertiary(self))
            }
        }

        public enum TextLink: ColorSetConvertibleProtocol {
            case normal
            case pressed

            public var convertible: ColorConvertible {
                UserInterfaceConfiguration.colorProvider.color(set: Buttons.textLink(self))
            }
        }
    }
}

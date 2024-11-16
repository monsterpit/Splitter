//
//  GenericColorProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//
import Foundation
import SharedCoreUI
import SwiftUI

/// Common color provider for generic colors and brand colors that share the same name
/// For specific use cases when branded asset catalogues cannot resolve the difference use BrandColorProvider
class ColorProvider: ColorProviderProtocol {
    func color(set: ColorSet.Buttons) -> ColorConvertible {
        let resource: ColorResource = switch set {
        case let .primary(color):
            switch color {
            case .background: .Buttons.Primary.background
            case .backgroundPressed: .Buttons.Primary.backgroundPressed
            case .backgroundDisabled: .Grey.color300
            case .text: .Buttons.Primary.text
            case .textDisabled: .Grey.color500
            }
        case let .secondary(color):
            switch color {
            case .stroke: .Buttons.Secondary.stroke
            case .strokePressed: .Buttons.Secondary.strokePressed
            case .text: .Buttons.Secondary.text
            case .disabled: .Grey.color300
            case .icon: .Buttons.Secondary.icon
            }
        case let .tertiary(color):
            switch color {
            case .background: .Buttons.Tertiary.background
            case .backgroundPressed: .Buttons.Tertiary.backgroundPressed
            case .backgroundDisabled: .Grey.color300
            case .icon: .Buttons.Tertiary.icon
            case .text: .Buttons.Tertiary.text
            case .textDisabled: .Grey.color500
            }
        case let .textLink(color):
            switch color {
            case .normal: .Buttons.TextLink.textNormal
            case .pressed: .Buttons.TextLink.textPressed
            }
        }
        return .resource(resource)
    }

    func color(set: ColorSet.Generic) -> ColorConvertible {
        let resource: ColorResource = switch set {
        case .black: .Basic.black
        case .white: .Basic.white
        case let .background(color):
            switch color {
            case .coolState: .Background.coolState
            case .white: .Background.white
            case .lightGrey: .Background.lightGrey
            }
        case let .grey(color):
            switch color {
            case .color0: .Grey.color0
            case .color100: .Grey.color100
            case .color200: .Grey.color200
            case .color300: .Grey.color300
            case .color400: .Grey.color400
            case .color500: .Grey.color500
            case .color600: .Grey.color600
            case .color700: .Grey.color700
            case .color800: .Grey.color800
            case .color900: .Grey.color900
            case .color1000: .Grey.color1000
            }
        case let .red(color):
            switch color {
            case .color0: .Red.color0
            case .color600: .Red.color600
            }
        case let .green(color):
            switch color {
            case .color0: .Green.color0
            case .color100: .Green.color100
            case .color200: .Green.color200
            case .color300: .Green.color300
            case .color400: .Green.color400
            case .color500: .Green.color500
            case .color600: .Green.color600
            case .color700: .Green.color700
            case .color800: .Green.color800
            case .color900: .Green.color900
            case .color1000: .Green.color1000
            }
        case let .orange(color):
            switch color {
            case .color700: .Orange.color700
            }
        }
        return .resource(resource)
    }

    func color(set: ColorSet.Accent) -> ColorConvertible {
        let resource: ColorResource = switch set {
        case let .primary(color):
            switch color {
            case .primary: .Accent.primary
            case .primaryLighter: .Accent.primaryLighter
            case .primaryFocusDarker: .Accent.primaryFocusDarker
            case .primaryDarker: .Accent.primaryDarker
            }
        case .secondary: .Accent.secondary
        case .primaryIcon: .Accent.primaryIcon
        }
        return .resource(resource)
    }
}

extension ColorResource: ColorConvertibleProtocol {
    func toUIColor() -> UIColor {
        .init(resource: self)
    }

    func toColor() -> SwiftUI.Color {
        .init(self)
    }
}

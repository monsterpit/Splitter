//
//  ColorConvertible.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public protocol ColorConvertibleProtocol {
    func toUIColor() -> UIColor
    func toColor() -> Color
}

/// Added for convenient way to provide clear color
public enum ColorConvertible: ColorConvertibleProtocol {
    case resource(ColorConvertibleProtocol)
    case clear

    public func toUIColor() -> UIColor {
        switch self {
        case let .resource(convertible):
            return convertible.toUIColor()
        case .clear:
            return .clear
        }
    }

    public func toColor() -> Color {
        switch self {
        case let .resource(convertible):
            return convertible.toColor()
        case .clear:
            return .clear
        }
    }
}

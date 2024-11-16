//
//  AppFontModifier.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public struct AppFontModifier: ViewModifier {
    private let font: Font
    private let lineHeight: CGFloat?
    private let fontLineHeight: CGFloat

    public init(font: UIFont, lineHeight: CGFloat?) {
        self.font = .init(font)
        fontLineHeight = font.lineHeight
        self.lineHeight = lineHeight
    }

    public func body(content: Content) -> some View {
        if let lineHeight {
            content
                .font(font)
                .lineSpacing(lineHeight - fontLineHeight)
                .padding(.vertical, (lineHeight - fontLineHeight) / 2)
        } else {
            content.font(font)
        }
    }
}

public extension View {
    func appFont(style: FontSet.TextStyle, weight: FontSet.Weight, lineHeight: CGFloat? = nil) -> some View {
        let font = UserInterfaceConfiguration.fontProvider.font(style: style, weight: weight)
        let lnHeight = lineHeight ?? UserInterfaceConfiguration.fontProvider.customLineHeight(style: style)
        return modifier(AppFontModifier(font: font, lineHeight: lnHeight))
    }

    func appFont(size: CGFloat, weight: FontSet.Weight, lineHeight: CGFloat? = nil) -> some View {
        let font = UserInterfaceConfiguration.fontProvider.font(size: size, weight: weight)
        return modifier(AppFontModifier(font: font, lineHeight: lineHeight))
    }
}

public extension Text {
    func font(style: FontSet.TextStyle, weight: FontSet.Weight) -> Text {
        let font = UserInterfaceConfiguration.fontProvider.font(style: style, weight: weight)
        return self.font(.init(font))
    }
}

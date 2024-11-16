//
//  BrandFontProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//
import SharedCoreUI
import UIKit

struct BrandFontProvider: FontProviderProtocol {
    func customLineHeight(style: FontSet.TextStyle) -> CGFloat? {
        style.systemFontAttributes.lineHeight
    }

    func font(style: FontSet.TextStyle, weight: FontSet.Weight) -> UIFont {
        .systemFont(ofSize: fontSize(for: style), weight: weight.uiWeight)
    }

    func font(size: CGFloat, weight: FontSet.Weight) -> UIFont {
        .systemFont(ofSize: size, weight: weight.uiWeight)
    }

    private func fontSize(for style: FontSet.TextStyle) -> CGFloat {
        let attr = style.systemFontAttributes
        return UIFont.preferredFont(forTextStyle: attr.systemStyle).pointSize + attr.sizeModifier
    }
}

private extension FontSet.TextStyle {
    struct FontAttribbutes {
        let systemStyle: UIFont.TextStyle
        let sizeModifier: CGFloat
        let lineHeight: CGFloat
    }

    /// returns system text style, size modifier and preferred line height
    /// system style is picked based on default Large type size from
    /// https://developer.apple.com/design/human-interface-guidelines/typography#iOS-iPadOS-Dynamic-Type-sizes
    /// because the Design Typography has different font sizes we need to modify the preferred font size in order to provide accurate fonts
    /// positive modifier will be added to the preferred font size, negative will be substracted
    var systemFontAttributes: FontAttribbutes {
        switch self {
        case .display1: // 96pt
            .init(systemStyle: .largeTitle, sizeModifier: 62, lineHeight: 115)
        case .display2: // 84pt
            .init(systemStyle: .largeTitle, sizeModifier: 50, lineHeight: 101)
        case .display3: // 72pt
            .init(systemStyle: .largeTitle, sizeModifier: 38, lineHeight: 86)
        case .heading1: // 60pt
            .init(systemStyle: .largeTitle, sizeModifier: 26, lineHeight: 72)
        case .heading2: // 48pt
            .init(systemStyle: .largeTitle, sizeModifier: 14, lineHeight: 58)
        case .heading3: // 40pt
            .init(systemStyle: .largeTitle, sizeModifier: 6, lineHeight: 48)
        case .heading4: // 32pt
            .init(systemStyle: .title1, sizeModifier: 4, lineHeight: 38)
        case .heading5: // 24pt
            .init(systemStyle: .title2, sizeModifier: 4, lineHeight: 31)
        case .bodyXl: // 20pt
            .init(systemStyle: .title3, sizeModifier: 0, lineHeight: 30)
        case .bodyLg: // 18pt
            .init(systemStyle: .body, sizeModifier: 1, lineHeight: 27)
        case .bodyMd: // 16pt
            .init(systemStyle: .body, sizeModifier: 0, lineHeight: 21)
        case .bodySm: // 14pt
            .init(systemStyle: .subheadline, sizeModifier: -1, lineHeight: 21)
        case .bodyXSm: // 12pt
            .init(systemStyle: .caption1, sizeModifier: 0, lineHeight: 16)
        case .buttonLg: // 18pt
            .init(systemStyle: .body, sizeModifier: 1, lineHeight: 22)
        case .buttonMd: // 16pt
            .init(systemStyle: .body, sizeModifier: 1, lineHeight: 20)
        case .buttonSm: // 14pt
            .init(systemStyle: .subheadline, sizeModifier: -1, lineHeight: 18)
        case .buttonXXS: // 11pt
            .init(systemStyle: .caption1, sizeModifier: -1, lineHeight: 14)
        }
    }
}

private extension FontSet.Weight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .regular:
            UIFont.Weight.regular
        case .medium:
            UIFont.Weight.medium
        case .semibold:
            UIFont.Weight.semibold
        case .bold:
            UIFont.Weight.bold
        }
    }
}

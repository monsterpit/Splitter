//
//  ActionButtonModifier.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import SwiftUI

struct ActionButtonModifier: ViewModifier {
    let attributes: ActionButtonModifierAttributesProtocol
    let leftImage: UIImage?
    let rightImage: UIImage?

    func body(content: Content) -> some View {
        HStack(spacing: attributes.spacing) {
            if attributes.autoSpace {
                Spacer(minLength: attributes.horizontalPadding)
            }
            if let leftImage {
                Image(uiImage: leftImage)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(attributes.iconColor)
            }
            content
                .foregroundColor(attributes.textColor)
                .appFont(style: attributes.fontStyle.style, weight: attributes.fontStyle.weight)
            if let rightImage {
                Image(uiImage: rightImage)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(attributes.iconColor)
            }
            if attributes.autoSpace {
                Spacer(minLength: attributes.horizontalPadding)
            }
        }
        .frame(height: attributes.height, alignment: .center)
        .contentShape(Rectangle()) // this needed to enable tap on the whole button shape
    }
}

protocol ActionButtonModifierAttributesProtocol {
    var textColor: Color { get }
    var iconColor: Color { get }
    var spacing: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var height: CGFloat { get }
    var fontStyle: FontSet.Style { get }
    var autoSpace: Bool { get }
}

extension ActionButtonModifierAttributesProtocol {
    var autoSpace: Bool { true }
}

extension View {
    func actionButton(attributes: ActionButtonModifierAttributesProtocol,
                      leftImage: UIImage?,
                      rightImage: UIImage?) -> some View
    {
        modifier(ActionButtonModifier(attributes: attributes, leftImage: leftImage, rightImage: rightImage))
    }
}

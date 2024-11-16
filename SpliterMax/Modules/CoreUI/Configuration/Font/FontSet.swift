//
//  FontSet.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public enum FontSet {
    public typealias Style = (style: TextStyle, weight: Weight)

    public enum TextStyle {
        /// Display
        case display1, display2, display3
        /// Heading
        case heading1, heading2, heading3, heading4, heading5
        /// Body
        case bodyXl, bodyLg, bodyMd, bodySm, bodyXSm
        /// Button
        case buttonLg, buttonMd, buttonSm, buttonXXS
    }

    public enum Weight {
        case regular, medium, semibold, bold
    }
}

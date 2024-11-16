//
//  FontProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public protocol FontProviderProtocol {
    func font(style: FontSet.TextStyle, weight: FontSet.Weight) -> UIFont

    func font(size: CGFloat, weight: FontSet.Weight) -> UIFont

    func customLineHeight(style: FontSet.TextStyle) -> CGFloat?
}

extension FontProviderProtocol {
    func customLineHeight(style _: FontSet.TextStyle) -> CGFloat? { nil }
}

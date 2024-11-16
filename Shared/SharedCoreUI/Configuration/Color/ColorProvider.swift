//
//  ColorProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public protocol ColorProviderProtocol {
    func color(set: ColorSet.Generic) -> ColorConvertible
    func color(set: ColorSet.Accent) -> ColorConvertible
    func color(set: ColorSet.Buttons) -> ColorConvertible
}

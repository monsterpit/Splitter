//
//  GeometrySet.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public protocol FloatConvertibleProtocol {
    var constant: CGFloat { get }
}

/// Namespace for cases when geometry constants depends on brand
public enum GeometrySet: FloatConvertibleProtocol {
    case buttonCornerRadius
    case cardViewCornerRadius

    public var constant: CGFloat {
        UserInterfaceConfiguration.geometryProvider.constant(geometry: self)
    }
}

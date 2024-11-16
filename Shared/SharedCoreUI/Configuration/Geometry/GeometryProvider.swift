//
//  GeometryProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public protocol GeometryProviderProtocol {
    func constant(geometry: GeometrySet) -> CGFloat
}

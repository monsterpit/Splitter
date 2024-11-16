//
//  BrandGeometryProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation

class BrandGeometryProvider: GeometryProviderProtocol {
    func constant(geometry: GeometrySet) -> CGFloat {
        switch geometry {
        case .buttonCornerRadius: 4
        case .cardViewCornerRadius: 6
        }
    }
}

//
//  GenericImageProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation
import SharedCoreUI
import SwiftUI

/// Common image provider for generic images and brand images that share the same name
/// For specific use cases when branded asset catalogues cannot resolve the difference use BrandImageProvider
class ImageProvider: ImageProviderProtocol {
    func image(set: ImageSet.Help) -> ImageConvertible {
        let resource: ImageResource = switch set {
        case let .info(info):
            switch info {
            case .bold: .Help.Info.bold
            case .regular: .Help.Info.regular
            case .warning: .Help.Info.warning
            }
        case let .warning(warning):
            switch warning {
            case .bold: .Help.Warning.bold
            }
        }
        return .resource(resource)
    }
}

extension ImageResource: ImageConvertibleProtocol {
    func toUIImage() -> UIImage {
        .init(resource: self)
    }

    func toImage() -> SwiftUI.Image {
        .init(self)
    }
}

//
//  ImageSet.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

/// Convenience protocol that allows to get resource directly from ImageSet namespace:
/// e.g.: ImageSet.Search.clear.toImage()
public protocol ImageSetConvertibleProtocol: ImageConvertibleProtocol {
    var convertible: ImageConvertible { get }
}

public extension ImageSetConvertibleProtocol {
    func toUIImage() -> UIImage {
        convertible.toUIImage()
    }

    func toImage() -> Image {
        convertible.toImage()
    }
}

public enum ImageSet {
    public enum Help {
        case info(Info), warning(Warning)

        public enum Info: ImageSetConvertibleProtocol {
            case regular, bold, warning

            public var convertible: ImageConvertible {
                UserInterfaceConfiguration.imageProvider.image(set: Help.info(self))
            }
        }

        public enum Warning: ImageSetConvertibleProtocol {
            case bold

            public var convertible: ImageConvertible {
                UserInterfaceConfiguration.imageProvider.image(set: Help.warning(self))
            }
        }
    }
}

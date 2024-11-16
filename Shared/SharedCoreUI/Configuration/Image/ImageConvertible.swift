//
//  ImageConvertible.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI

public protocol ImageConvertibleProtocol {
    func toUIImage() -> UIImage
    func toImage() -> Image
}

/// Added to support cases where no image is provided
/// Note that none image will still convert into blank UIImage() so whenever no image is expected guard it with isImage
public enum ImageConvertible: ImageConvertibleProtocol {
    case resource(ImageConvertibleProtocol)
    case none

    public var isImage: Bool {
        switch self {
        case .resource:
            true
        case .none:
            false
        }
    }

    public func toUIImage() -> UIImage {
        switch self {
        case let .resource(convertible):
            return convertible.toUIImage()
        case .none:
            return UIImage()
        }
    }

    public func toImage() -> Image {
        switch self {
        case let .resource(convertible):
            return convertible.toImage()
        case .none:
            return Image(uiImage: UIImage())
        }
    }
}

// use for previews only
extension UIImage: ImageConvertibleProtocol {
    public func toImage() -> Image {
        .init(uiImage: self)
    }

    public func toUIImage() -> UIImage {
        self
    }
}

//
//  ImageProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public protocol ImageProviderProtocol {
    func image(set: ImageSet.Help) -> ImageConvertible
}

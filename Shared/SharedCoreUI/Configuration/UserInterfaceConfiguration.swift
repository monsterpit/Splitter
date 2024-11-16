//
//  UserInterfaceConfiguration.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
import Utils

public protocol ConfigurationProvidersProtocol {
    var fontProvider: FontProviderProtocol { get }
    var colorProvider: ColorProviderProtocol { get }
    var imageProvider: ImageProviderProtocol { get }
    var geometryProvider: GeometryProviderProtocol { get }
    var styleProvider: StyleProviderProtocol { get }
}

/// Shared UI configuration designed to be used across all UI modules
public final class UserInterfaceConfiguration {
    public static var fontProvider: FontProviderProtocol {
        shared.font.provider
    }

    public static var colorProvider: ColorProviderProtocol {
        shared.color.provider
    }

    public static var imageProvider: ImageProviderProtocol {
        shared.image.provider
    }

    public static var geometryProvider: GeometryProviderProtocol {
        shared.geometry.provider
    }

    public static var styleProvider: StyleProviderProtocol {
        shared.style.provider
    }

    public static var appState: AppState? {
        shared.appState
    }

    static let shared = UserInterfaceConfiguration()

    var font: ResourceProvider<FontProviderProtocol> = .init(provider: nil)
    var color: ResourceProvider<ColorProviderProtocol> = .init(provider: nil)
    var image: ResourceProvider<ImageProviderProtocol> = .init(provider: nil)
    var geometry: ResourceProvider<GeometryProviderProtocol> = .init(provider: nil)
    var style: ResourceProvider<StyleProviderProtocol> = .init(provider: nil)

    private var appState: AppState?

    public static func configure(providers: ConfigurationProvidersProtocol) {
        shared.font = ResourceProvider(provider: providers.fontProvider)
        shared.color = ResourceProvider(provider: providers.colorProvider)
        shared.image = ResourceProvider(provider: providers.imageProvider)
        shared.geometry = ResourceProvider(provider: providers.geometryProvider)
        shared.style = ResourceProvider(provider: providers.styleProvider)
    }

    public static func configure(appState: AppState) {
        shared.appState = appState
    }
}

struct ResourceProvider<Provider> {
    private let _provider: Provider?

    var provider: Provider {
        guard let _provider else {
            fatalError("CollinsonUIKit is not configured")
        }
        return _provider
    }

    init(provider: Provider?) {
        _provider = provider
    }
}

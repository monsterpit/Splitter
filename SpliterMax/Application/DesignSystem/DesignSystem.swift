//
//  DesignSystem.swift
//  LocalizationKit
//
//  Created by Vikas Salian on 16/11/24.
//
import Foundation
import SharedCoreUI
import UIKit
import Utils

public enum DesignSystem {
    public static func configure(appState: AppState) {
        let providers = ConfigurationProviders(fontProvider: BrandFontProvider(),
                                               colorProvider: BrandColorProvider(),
                                               imageProvider: BrandImageProvider(),
                                               geometryProvider: BrandGeometryProvider(),
                                               styleProvider: BrandStyleProvider())
        UserInterfaceConfiguration.configure(providers: providers)
        UserInterfaceConfiguration.configure(appState: appState)

        configureAppearance()
    }

    private static func configureAppearance() {
        let standardAppearance = UITabBarAppearance()
        standardAppearance.shadowColor = .white
        standardAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = standardAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = standardAppearance
        }
        UITabBar.appearance().tintColor = .purple // .Accent.primary
    }
}

final class ConfigurationProviders: ConfigurationProvidersProtocol {
    var fontProvider: FontProviderProtocol
    var colorProvider: ColorProviderProtocol
    var imageProvider: ImageProviderProtocol
    var geometryProvider: GeometryProviderProtocol
    var styleProvider: StyleProviderProtocol

    init(fontProvider: FontProviderProtocol,
         colorProvider: ColorProviderProtocol,
         imageProvider: ImageProviderProtocol,
         geometryProvider: GeometryProviderProtocol,
         styleProvider: StyleProviderProtocol)
    {
        self.fontProvider = fontProvider
        self.colorProvider = colorProvider
        self.imageProvider = imageProvider
        self.geometryProvider = geometryProvider
        self.styleProvider = styleProvider
    }
}

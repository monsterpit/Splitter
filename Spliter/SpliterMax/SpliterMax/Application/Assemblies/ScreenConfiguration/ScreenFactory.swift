//
//  ScreenFactory.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Swinject
import SwinjectAutoregistration
import UIKit

protocol ScreenFactoryProtocol {
    func assemble<Config>(_ name: ScreenName, configuration: Config) -> UIViewController?
    func assemble(_ name: ScreenName) -> UIViewController?
}

struct ScreenFactory: ScreenFactoryProtocol {
    let resolver: Resolver

    func assemble(_ name: ScreenName, configuration: some Any) -> UIViewController? {
        resolver.resolve(UIViewController.self, name: name.rawValue, argument: configuration)
    }

    func assemble(_ name: ScreenName) -> UIViewController? {
        resolver.resolve(UIViewController.self, name: name.rawValue)
    }
}

//
//  ScreenFactory.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

// TODO: Vikas check if we need it
import UIKit

protocol ScreenFactoryProtocol {
    func assemble<Config>(_ name: ScreenName, configuration: Config) -> UIViewController?
    func assemble(_ name: ScreenName) -> UIViewController?
}

struct ScreenFactory: ScreenFactoryProtocol {
//    let resolver: Resolver

    func assemble(_: ScreenName, configuration _: some Any) -> UIViewController? {
//        resolver.resolve(UIViewController.self, name: name.rawValue, argument: configuration)
        return nil
    }

    func assemble(_: ScreenName) -> UIViewController? {
//        resolver.resolve(UIViewController.self, name: name.rawValue)
        return nil
    }
}

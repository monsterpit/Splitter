//
//  ExploreAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Explore
import SharedCoreUI
import SwiftUI
import Swinject
import SwinjectAutoregistration
import UIKit
import Utils

extension ScreenName {
    static var explore: Self { .selfName() }
}

struct ExploreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TabViewProtocol.self,
                           name: ScreenName.explore.rawValue)
        { (_, _: MainTabBarCoordinatorProtocol) in

            let exploreView = ExploreView()

            return TabContainerView(tabTitle: "explore",
                                    tabImage: UIImage(resource: .Help.Info.bold),
                                    tabImageSelected: UIImage(resource: .Help.Info.bold))
            {
                exploreView
            }
        }
    }
}

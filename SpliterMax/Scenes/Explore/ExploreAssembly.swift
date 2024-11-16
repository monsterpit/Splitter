//
//  ExploreAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI
import UIKit

extension ScreenName {
    static var explore: Self { .selfName() }
}

struct ExploreAssembly {
    var exploreTab: TabContainerView

    init() {
        let exploreView = ExploreView()
        let wow = UIImage(named: "globe")
        // UIImage(systemName: "house.fill") ??
        exploreTab = TabContainerView(tabTitle: "explore",
                                      tabImage: UIImage(resource: .Help.Info.bold),
                                      tabImageSelected: UIImage(resource: .Help.Info.bold))
        {
            exploreView
        }
    }
}

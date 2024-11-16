//
//  TabContainerView.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import SwiftUI
import UIKit
import Utils

/// TabContainerView is used to confirm your view to tabview
public struct TabContainerView: ViewControllableProtocol, TabViewProtocol {
    public var holder: ViewControllerHolder
    public let content: any ViewControllableProtocol
    public let tabTitle: String
    public let tabImage: UIImage
    public let tabImageSelected: UIImage

    public var viewController: UIViewController {
        content.viewController
    }

    public init(tabTitle: String,
                tabImage: UIImage,
                tabImageSelected: UIImage,
                @ViewBuilder content: () -> any ViewControllableProtocol)
    {
        let content = content()
        self.content = content
        holder = content.holder
        self.tabTitle = tabTitle
        self.tabImage = tabImage
        self.tabImageSelected = tabImageSelected
    }

    public var body: some View {
        AnyView(content)
    }
}

//
//  TabViewProtocol.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import UIKit

public protocol TabViewProtocol {
    var viewController: UIViewController { get }
    var tabTitle: String { get }
    var tabImage: UIImage { get }
    var tabImageSelected: UIImage { get }
    
    var tabBarItem: UITabBarItem { get }
}

public extension TabViewProtocol {
    var tabBarItem: UITabBarItem {
        .init(title: tabTitle, image: tabImage, selectedImage: tabImageSelected)
    }
}

//
//  NavigationBarStyle.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import UIKit

struct NavigationBarStyle {
    let standardAppearance: UINavigationBarAppearance
    var scrollEdgeAppearance: UINavigationBarAppearance?
    var tintColor: UIColor = .black
    var layoutMargins: NSDirectionalEdgeInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
    var prefersLargeTitles = false

    static var `default`: NavigationBarStyle {
        .init(standardAppearance: .default)
    }
}

extension UINavigationBar {
    func applyStyle(_ style: NavigationBarStyle) {
        prefersLargeTitles = style.prefersLargeTitles
        tintColor = style.tintColor
        directionalLayoutMargins = style.layoutMargins
        standardAppearance = style.standardAppearance
        scrollEdgeAppearance = style.scrollEdgeAppearance ?? style.standardAppearance
    }
}

extension UINavigationBarAppearance {
    static var `default`: UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black,
        ]

        navBarAppearance.backButtonAppearance = .defaultBackButton
//        navBarAppearance.setBackIndicatorImage(UIImage(), transitionMaskImage: UIImage())

        return navBarAppearance
    }
}

extension UIBarButtonItemAppearance {
    static var defaultBackButton: UIBarButtonItemAppearance {
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black,
        ]
        buttonAppearance.highlighted.titleTextAttributes = [
            .foregroundColor: UIColor.black,
        ]
        return buttonAppearance
    }
}

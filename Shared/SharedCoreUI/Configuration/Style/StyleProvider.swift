//
//  StyleProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public protocol StyleProviderProtocol {
    func style(set: StyleSet.ActionButton) -> ActionButtonStyle.Style
}

/// Namespace for unusual cases when existing styles not used consistently among brands
public enum StyleSet {
    public enum ActionButton {
        case generic

        public var style: ActionButtonStyle.Style {
            UserInterfaceConfiguration.styleProvider.style(set: self)
        }
    }
}

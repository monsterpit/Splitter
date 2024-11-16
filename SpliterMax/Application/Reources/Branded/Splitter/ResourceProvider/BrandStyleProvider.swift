//
//  BrandStyleProvider.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import Foundation

class BrandStyleProvider: StyleProviderProtocol {
    func style(set: StyleSet.ActionButton) -> ActionButtonStyle.Style {
        switch set {
        case .generic: .tertiary
        }
    }
}

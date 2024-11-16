//
//  ActionButtonConfiguration+Utils.swift
//  Splitter
//
//  Created by Vikas Salian on 16/11/24.
//

import SwiftUI

extension ActionButtonConfiguration.ColorConfiguration {
    func color(isEnabled: Bool, isPressed: Bool) -> Color {
        guard isEnabled else {
            return disabled.toColor()
        }
        return isPressed ? pressed.toColor() : normal.toColor()
    }
}

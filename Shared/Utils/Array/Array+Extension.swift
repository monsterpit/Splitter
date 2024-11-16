//
//  Array.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation
// MARK: - Array

extension Array {
    public subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

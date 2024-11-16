//
//  ScreenName.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

struct ScreenName: RawRepresentable, Hashable {
    var rawValue: String
    
    static func selfName(_ rawValue: StaticString = #function) -> Self {
        Self(rawValue: "\(rawValue)")
    }
}

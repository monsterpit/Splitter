//
//  ScreenConfiguration.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public struct ScreenConfiguration<Coordinator> {
    public let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}


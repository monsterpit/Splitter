//
//  KeyValueStorageProtocol.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol KeyValueStorageProtocol {
    func getValue<T: Codable>(by key: String) -> T?
    func setValue<T: Codable>(value: T, by key: String)
    func clearValue(for key: String)
}

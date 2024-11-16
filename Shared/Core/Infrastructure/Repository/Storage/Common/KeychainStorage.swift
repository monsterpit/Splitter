//
//  KeychainStorage.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public final class KeychainStorage: KeyValueStorageProtocol {
    private let keychainAccessibility = kSecAttrAccessibleAfterFirstUnlock as String
    private let service: String
    
    public init(service: String) {
        self.service = service
    }

    public func getValue<T>(by key: String) -> T? where T: Codable {
        guard let data = KeychainUtil.get(forKey: key, service: service, group: nil, accessible: keychainAccessibility) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    public func setValue(value: some Codable, by key: String) {
        if let data = try? JSONEncoder().encode(value) {
            KeychainUtil.set(data, forKey: key, service: service, group: nil, accessible: keychainAccessibility)
        }
    }

    public func clearValue(for key: String) {
        KeychainUtil.remove(forKey: key, service: service, group: nil, accessible: keychainAccessibility)
    }
}

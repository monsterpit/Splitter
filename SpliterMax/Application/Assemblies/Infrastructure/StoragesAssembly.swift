//
//  StoragesAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

enum StoragesAssembly {
    static var keychain: KeyValueStorageProtocol {
        KeychainStorage(service: keyChainServiceName)
    }

    static var userDefault: KeyValueStorageProtocol {
        UserDefaultsStorage()
    }
}

extension StoragesAssembly {
    private static let keyChainServiceName = "\(Bundle.main.bundleIdentifier ?? "").keychainStorage"

    enum KeyValueStorageType {
        static let userDefaults = "userDefaults"
        static let keychain = "keychain"
    }
}

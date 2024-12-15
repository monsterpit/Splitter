//
//  StoragesAssembly.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation
import Infrastructure
import Swinject
import SwinjectAutoregistration

struct StoragesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(KeyValueStorageProtocol.self, name: KeyValueStorageType.keychain) { _ in
            KeychainStorage(service: Self.keyChainServiceName)
        }
        .inObjectScope(.weak)

        container.register(KeyValueStorageProtocol.self, name: KeyValueStorageType.userDefaults) { _ in
            UserDefaultsStorage()
        }
        .inObjectScope(.weak)

        container.register(ApplicationSessionStorageProtocol.self) { resolver in
            ApplicationSessionStorage(keyValueStorage: userDefaultsStorage(resolver: resolver))
        }
    }

    private func userDefaultsStorage(resolver: Resolver) -> KeyValueStorageProtocol {
        resolver ~> (KeyValueStorageProtocol.self, name: KeyValueStorageType.userDefaults)
    }

    private func keychainStorage(resolver: Resolver) -> KeyValueStorageProtocol {
        resolver ~> (KeyValueStorageProtocol.self, name: KeyValueStorageType.keychain)
    }
}

extension StoragesAssembly {
    private static let keyChainServiceName = "\(Bundle.main.bundleIdentifier ?? "").keychainStorage"

    enum KeyValueStorageType {
        static let userDefaults = "userDefaults"
        static let keychain = "keychain"
    }
}

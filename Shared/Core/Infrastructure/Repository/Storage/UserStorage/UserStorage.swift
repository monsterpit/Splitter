//
//  UserStorage.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Domain
import Foundation

// sourcery: AutoMockable
public protocol UserStorageProtocol {
    func getUser() -> User?
    func saveUser(_ user: User)
    func deleteUser()
}

public final class UserKeychainStorage {
    private let keychainStorage: KeyValueStorageProtocol
    private let userDefaultsStorage: KeyValueStorageProtocol

    public init(keychainStorage: KeyValueStorageProtocol, userDefaultsStorage: KeyValueStorageProtocol) {
        self.keychainStorage = keychainStorage
        self.userDefaultsStorage = userDefaultsStorage
    }
}

extension UserKeychainStorage: UserStorageProtocol {
    public func getUser() -> User? {
        guard let userData: UserStorageModel = keychainStorage.getValue(by: Keys.user) else {
            return nil
        }
        return userData.entity
    }

    public func saveUser(_ user: User) {
        let userData = UserStorageModel(user: user)
        keychainStorage.setValue(value: userData, by: Keys.user)
    }

    public func deleteUser() {
        keychainStorage.clearValue(for: Keys.user)
    }
}

private extension UserKeychainStorage {
    enum Keys {
        static let user = "user"
    }
}

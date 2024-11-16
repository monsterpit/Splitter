//
//  UserDefaultsStorage.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public final class UserDefaultsStorage: KeyValueStorageProtocol {
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public func getValue<T>(by key: String) -> T? where T: Decodable, T: Encodable {
        guard let objectData = defaults.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: objectData)
    }

    public func setValue(value: some Decodable & Encodable, by key: String) {
        if let objectData = try? JSONEncoder().encode(value) {
            defaults.set(objectData, forKey: key)
        }
    }

    public func clearValue(for key: String) {
        defaults.removeObject(forKey: key)
    }
}

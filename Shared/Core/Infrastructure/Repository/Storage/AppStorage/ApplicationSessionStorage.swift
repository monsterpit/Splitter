//
//  ApplicationSessionStorage.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol ApplicationSessionStorageProtocol {
    var firstOpenDate: Date? { get set }
    var lastOpenDate: Date? { get set }
    var lastOpenVersion: String? { get set }
    func set(appId: String, for userEmail: String)
    func getAppId(by userEmailOrPhone: String) -> String?
    func deleteMobileAppData()
}

public final class ApplicationSessionStorage {
    let userDefaultsStorage: KeyValueStorageProtocol

    public init(keyValueStorage: KeyValueStorageProtocol) {
        self.userDefaultsStorage = keyValueStorage
    }
}

extension ApplicationSessionStorage: ApplicationSessionStorageProtocol {
    public var firstOpenDate: Date? {
        get {
            userDefaultsStorage.getValue(by: Keys.firstOpenDate)
        }
        set {
            userDefaultsStorage.setValue(value: newValue, by: Keys.firstOpenDate)
        }
    }
    
    public var lastOpenDate: Date? {
        get {
            userDefaultsStorage.getValue(by: Keys.lastOpenDate)
        }
        set {
            userDefaultsStorage.setValue(value: newValue, by: Keys.lastOpenDate)
        }
    }
    
    public var lastOpenVersion: String? {
        get {
            userDefaultsStorage.getValue(by: Keys.lastOpenVersion)
        }
        set {
            userDefaultsStorage.setValue(value: newValue, by: Keys.lastOpenVersion)
        }
    }
    
    public func deleteMobileAppData() {
        userDefaultsStorage.clearValue(for: Keys.mobileAppData)
    }

    public func set(appId: String, for userEmail: String) {
        if var appIdsDictionary: [String: String] = userDefaultsStorage.getValue(by: Keys.appId) {
            appIdsDictionary[userEmail] = appId
            userDefaultsStorage.setValue(value: appIdsDictionary, by: Keys.appId)
        } else {
            let newDictionary = [userEmail: appId]
            userDefaultsStorage.setValue(value: newDictionary, by: Keys.appId)
        }
    }

    public func getAppId(by userEmailOrPhone: String) -> String? {
        if let appIdsDictionary: [String: String] = userDefaultsStorage.getValue(by: Keys.appId) {
            appIdsDictionary[userEmailOrPhone]
        } else {
            nil
        }
    }
}

private extension ApplicationSessionStorage {
    enum Keys {
        static let firstOpenDate = "firstOpenDate"
        static let lastOpenVersion = "lastOpenVersion"
        static let lastOpenDate = "lastOpenDate"
        static let mobileAppData = "mobileAppData"
        static let appId = "appId"
    }
}

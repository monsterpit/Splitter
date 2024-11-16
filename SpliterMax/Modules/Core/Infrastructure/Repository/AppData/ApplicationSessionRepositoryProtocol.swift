//
//  ApplicationSessionRepositoryProtocol.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public final class ApplicationSessionRepository {
    private let authRepository: AuthRepositoryCleanupProtocol
    private var storage: ApplicationSessionStorageProtocol
    private let appName: String

    public init(storage: ApplicationSessionStorageProtocol,
                authRepository: AuthRepositoryCleanupProtocol,
                appName: String)
    {
        self.storage = storage
        self.authRepository = authRepository
        self.appName = appName
    }
}

extension ApplicationSessionRepository: ApplicationSessionRepositoryProtocol {
    public var firstOpenDate: Date? {
        storage.firstOpenDate
    }

    public var lastOpenDate: Date? {
        storage.lastOpenDate
    }

    // cleanup keychain storages in case of app re-install
    public func initialCleanup() {
        authRepository.cleanup()
    }

    public func saveLaunchInfo(_ date: Date, appVersion: String) {
        if storage.firstOpenDate == nil {
            storage.firstOpenDate = date
        }
        storage.lastOpenDate = date
        storage.lastOpenVersion = appVersion
    }

    public func deleteMobileAppData() {
        storage.deleteMobileAppData()
    }
}

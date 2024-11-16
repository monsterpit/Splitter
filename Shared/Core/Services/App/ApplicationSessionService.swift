//
//  ApplicationSessionService.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public protocol ApplicationSessionServiceProtocol {
    func didLaunch(appVersion: String)
}

public final class ApplicationSessionService: ApplicationSessionServiceProtocol {
    private let repository: ApplicationSessionRepositoryProtocol
    
    public init(repository: ApplicationSessionRepositoryProtocol) {
        self.repository = repository
    }
    
    public func didLaunch(appVersion: String) {
        if repository.firstOpenDate == nil {
            repository.initialCleanup()
        }
        repository.saveLaunchInfo(Date(), appVersion: appVersion)
    }
}

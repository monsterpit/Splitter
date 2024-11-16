//
//  AuthRepository.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol AuthRepositoryCleanupProtocol {
    func cleanup()
}

public final class AuthRepository {
    public init() {}
}

extension AuthRepository: AuthRepositoryCleanupProtocol {
    public func cleanup() {
        // TODO: Vikas Authorization mechanism needed
    }
}

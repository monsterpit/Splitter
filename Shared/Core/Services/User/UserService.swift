//
//  UserService.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine
import Domain
import Foundation

public enum UserStorageType {
    case remote, local, localOrRemote, remoteOrLocal
}

public protocol UserServiceProtocol {
    func getUser(from storage: UserStorageType, completion: @escaping (Result<User, ApiError>) -> Void)
}

// sourcery: AutoMockable
public protocol UserServiceAsyncProtocol {
    var localUser: AnyPublisher<User?, Never> { get }
    func getUser(from storage: UserStorageType) async throws -> User
}

public final class UserService {
    private let repository: UserRepositoryProtocol

    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
}

extension UserService: UserServiceProtocol {
    public func getUser(from storage: UserStorageType, completion: @escaping (Result<User, ApiError>) -> Void) {
        repository.getUser(from: storage, completion: completion)
    }
}

extension UserService: UserServiceAsyncProtocol {
    public var localUser: AnyPublisher<User?, Never> {
        repository.localUser.eraseToAnyPublisher()
    }

    public func getUser(from storage: UserStorageType) async throws -> User {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else { return }
            getUser(from: storage) { result in
                continuation.resume(with: result)
            }
        }
    }
}

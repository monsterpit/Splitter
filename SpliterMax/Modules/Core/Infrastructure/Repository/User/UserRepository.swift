//
//  UserRepository.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//
import Combine
import Foundation

public final class UserRepository: UserRepositoryProtocol {
    public var localUser = CurrentValueSubject<User?, Never>(nil)

    private let storage: UserStorageProtocol
    private let logger: LoggerProtocol?

    public init(logger: LoggerProtocol?, storage: UserStorageProtocol) {
        self.storage = storage
        self.logger = logger
    }

    public func getUser(from storage: UserStorageType, completion: @escaping (Result<User, ApiError>) -> Void) {
        localUser.send(self.storage.getUser())
        let storeAndComplete: (Result<User, ApiError>) -> Void = { [weak self] result in
            if let user = try? result.get() {
                self?.saveUser(user)
            }
            completion(result)
        }
        switch storage {
        case .remote:
            completion(.failure(.noDataError()))
        // TODO: Vikas Fetching User
        // apiClient.getUser(completion: storeAndComplete)
        case .local:
            guard let localUser = localUser.value else {
                logger?.error(ApiError.noDataError(apiQuery: "LocalUserNotFound"))
                completion(.failure(.noDataError()))
                return
            }
            completion(.success(localUser))
        case .localOrRemote:
            guard let localUser = localUser.value else {
                // TODO: Vikas Fetching User
//                apiClient.getUser(completion: storeAndComplete)
                return
            }
            completion(.success(localUser))
        case .remoteOrLocal:
            completion(.failure(.noDataError()))
            // TODO: Vikas Fetching User
//            apiClient.getUser { [weak self] result in
//                switch result {
//                case .success:
//                    storeAndComplete(result)
//                case .failure(let error):
//                    if let localUser = self?.localUser.value {
//                        completion(.success(localUser))
//                    } else {
//                        self?.logger?.error(ApiError.noDataError(apiQuery: "LocalUserNotFound"))
//                        completion(.failure(error))
//                    }
//                }
//            }
        }
    }

    private func saveUser(_ user: User) {
        storage.saveUser(user)
        localUser.send(user) // Update the CurrentValueSubject
    }

    public func deleteLocalUser() {
        storage.deleteUser()
        localUser.send(nil) // Clear the CurrentValueSubject
    }
}

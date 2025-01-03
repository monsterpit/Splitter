//
//  UserRepositoryProtocol.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//
import Combine
import Domain
import Foundation

// sourcery: AutoMockable
public protocol UserRepositoryProtocol {
    var localUser: CurrentValueSubject<User?, Never> { get }

    func getUser(from storage: UserStorageType, completion: @escaping (Result<User, ApiError>) -> Void)
}

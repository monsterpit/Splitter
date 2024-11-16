//
//  NetworkMonitorRepositoryProtocol.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine
import Foundation

// sourcery: AutoMockable
public protocol NetworkMonitorRepositoryProtocol {
    var isConnected: Bool { get }
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}


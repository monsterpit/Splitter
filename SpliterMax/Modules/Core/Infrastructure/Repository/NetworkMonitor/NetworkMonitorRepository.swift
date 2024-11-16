//
//  NetworkMonitorRepository.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine
import Foundation
import Network

public final class NetworkMonitorRepository {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "com.core.infrastructure.networkmonitor")

    @Published public private(set) var isConnected = false

    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}

extension NetworkMonitorRepository: NetworkMonitorRepositoryProtocol {
    public var isConnectedPublisher: AnyPublisher<Bool, Never> {
        $isConnected.eraseToAnyPublisher()
    }
}

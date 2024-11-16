//
//  AppState.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Combine
 
import Foundation
 

public final class AppState: ObservableObject {
    @Published public var showActivityIndicator = false
    @Published public var showNoInternetPopup = false
    
    private let viewLoadTracker: ViewLoadTracker
    private let networkMonitor: NetworkMonitorRepositoryProtocol
    private var disposables = Set<AnyCancellable>()
    private var isConnectedToInternet = false
    private let queue = DispatchQueue(label: "com.core.reachabilityInterceptorAppStateQueue")
    
    public init(viewLoadTracker: ViewLoadTracker, networkMonitor: NetworkMonitorRepositoryProtocol) {
        self.viewLoadTracker = viewLoadTracker
        self.networkMonitor = networkMonitor
        self.networkMonitor.isConnectedPublisher
            .sink { [weak self] isConnected in
                self?.queue.async { [weak self] in
                    self?.isConnectedToInternet = isConnected
                    self?.showNoInternetPopup = !isConnected
                }
            }
            .store(in: &disposables)
    }
    
    public func viewDidAppear(screnName: String, screenClass: String) {
        viewLoadTracker.delegate.viewDidAppear(screnName: screnName, screenClass: screenClass)
    }
}

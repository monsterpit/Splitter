//
//  ViewLoadTracker.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol ViewLoadTrackerDelegateProtocol {
    func viewDidAppear(screnName: String, screenClass: String)
}

public final class ViewLoadTracker: ObservableObject {
    public let delegate: ViewLoadTrackerDelegateProtocol
    
    public init(delegate: ViewLoadTrackerDelegateProtocol) {
        self.delegate = delegate
    }
}


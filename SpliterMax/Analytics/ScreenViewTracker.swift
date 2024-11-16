//
//  ScreenViewTracker.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

final class ScreenViewTracker {
    private let analytics: AnalyticsServiceProtocol

    init(analytics: AnalyticsServiceProtocol) {
        self.analytics = analytics
    }
}

extension ScreenViewTracker: ViewLoadTrackerDelegateProtocol {
    func viewDidAppear(screnName: String, screenClass: String) {
        analytics.track(event: AnalyticsScreenEvent(screenName: screnName, screenClass: screenClass))
    }
}

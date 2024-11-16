//
//  ApplicationSessionRepository.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

// sourcery: AutoMockable
public protocol ApplicationSessionRepositoryProtocol: AnyObject {
    var firstOpenDate: Date? { get }
    var lastOpenDate: Date? { get }
    
    func saveLaunchInfo(_ date: Date, appVersion: String)
    func initialCleanup()
    func deleteMobileAppData()
}

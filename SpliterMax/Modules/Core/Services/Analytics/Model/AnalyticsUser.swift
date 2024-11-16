//
//  AnalyticsUser.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public struct AnalyticsUser {
    public let id: String
    public let membershipId: String
    public let souceCode: String
    public let registrationDate: String
    public let membershipStatus: String
    public let dealType: String

    public init(id: String, membershipId: String, souceCode: String, registrationDate: String, membershipStatus: String, dealType: String) {
        self.id = id
        self.membershipId = membershipId
        self.souceCode = souceCode
        self.registrationDate = registrationDate
        self.membershipStatus = membershipStatus
        self.dealType = dealType
    }

//    public init(user: User) {
//        self.id = user.id
//        self.membershipId = user.memberships.first?.id ?? ""
//        self.souceCode = "" // TODO: add after Be will add
//        self.registrationDate = user.createdAt
//        self.membershipStatus = user.memberships.first?.plan.status.rawValue ?? ""
//        self.dealType = "" // TODO: add after Be will add
//    }

    // For clear user
    public init(id: String) {
        self.id = id
        self.membershipId = ""
        self.souceCode = ""
        self.registrationDate = ""
        self.membershipStatus = ""
        self.dealType = ""
    }

    public var parameters: [AnalyticsEventParameterProtocol] {
        [
            AnalyticsEventParameter.userId(value: id),
            AnalyticsEventParameter.membershipId(value: membershipId),
            AnalyticsEventParameter.souceCode(value: souceCode),
            AnalyticsEventParameter.registrationDate(value: registrationDate),
            AnalyticsEventParameter.membershipStatus(value: membershipStatus),
            AnalyticsEventParameter.dealType(value: dealType)
        ]
    }
}

public extension AnalyticsEventParameter {
    static func userId(value: String) -> Self {
        .init(key: "id", value: value)
    }

    static func appId(value: String) -> Self {
        .init(key: "identifier", value: value)
    }

    static func membershipId(value: String) -> Self {
        .init(key: "membershipId", value: value)
    }

    static func souceCode(value: String) -> Self {
        .init(key: "souceCode", value: value)
    }

    static func registrationDate(value: String) -> Self {
        .init(key: "registrationDate", value: value)
    }

    static func membershipStatus(value: String) -> Self {
        .init(key: "membershipStatus", value: value)
    }

    static func dealType(value: String) -> Self {
        .init(key: "dealType", value: value)
    }
}

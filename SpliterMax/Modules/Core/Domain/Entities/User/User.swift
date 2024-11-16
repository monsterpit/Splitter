//
//  User.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public struct User: Equatable {
    public var id: String
    public var createdAt: String
    public var emailAddress: String?
    public var phone: String?
    public var phoneCountryCode: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var countryOfResidence: String?
    public var crmId: String?
    public var isEmailVerified: Bool?
    public var isPhoneVerified: Bool?
    public var primaryAuthenticator: LoginMethod?
    
    public var hasUserDetails: Bool {
        guard let firstName, let lastName, let countryOfResidence else {
            return false
        }
        return !firstName.isEmpty && !lastName.isEmpty && !countryOfResidence.isEmpty
    }
    
    public init(id: String,
                createdAt: String,
                emailAddress: String? = nil,
                phone: String? = nil,
                phoneCountryCode: String? = nil,
                firstName: String? = nil,
                lastName: String? = nil,
                fullName: String? = nil,
                countryOfResidence: String? = nil,
                crmId: String? = nil,
                isEmailVerified: Bool? = nil,
                isPhoneVerified: Bool? = nil,
                primaryAuthenticator: LoginMethod? = nil) {
        self.id = id
        self.emailAddress = emailAddress
        self.phone = phone
        self.phoneCountryCode = phoneCountryCode
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.countryOfResidence = countryOfResidence
        self.crmId = crmId
        self.isEmailVerified = isEmailVerified
        self.isPhoneVerified = isPhoneVerified
        self.primaryAuthenticator = primaryAuthenticator
        self.createdAt = createdAt
    }
}


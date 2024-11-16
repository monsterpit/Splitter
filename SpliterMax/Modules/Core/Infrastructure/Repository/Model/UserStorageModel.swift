//
//  UserStorageModel.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

struct UserStorageModel: Codable {
    let id: String
    let createdAt: String
    let emailAddress: String?
    let phone: String?
    var phoneCountryCode: String?
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let countryOfResidence: String?
    let crmId: String?
    let isEmailVerified: Bool?
    let isPhoneVerified: Bool?
    let primaryAuthenticator: String?

    init(user: User) {
        id = user.id
        emailAddress = user.emailAddress
        phone = user.phone
        phoneCountryCode = user.phoneCountryCode
        firstName = user.firstName
        lastName = user.lastName
        fullName = user.fullName
        countryOfResidence = user.countryOfResidence
        crmId = user.crmId
        isEmailVerified = user.isEmailVerified
        isPhoneVerified = user.isPhoneVerified
        primaryAuthenticator = user.primaryAuthenticator?.rawValue
        createdAt = user.createdAt
    }

    var entity: User {
        .init(id: id,
              createdAt: createdAt,
              emailAddress: emailAddress,
              phone: phone,
              phoneCountryCode: phoneCountryCode,
              firstName: firstName,
              lastName: lastName,
              fullName: fullName,
              countryOfResidence: countryOfResidence,
              crmId: crmId,
              isEmailVerified: isEmailVerified,
              isPhoneVerified: isPhoneVerified,
              primaryAuthenticator: LoginMethod(rawValue: primaryAuthenticator ?? ""))
    }
}

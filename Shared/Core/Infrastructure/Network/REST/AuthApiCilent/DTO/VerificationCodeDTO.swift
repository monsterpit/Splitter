//
// Copyright (c) 2023-present The Collinson Group Limited. All Rights Reserved.
//

import Foundation

struct VerificationCodeDTO: Codable {
    var status: String
    var createdNewUser: Bool?
    var user: UserDTO?
    var failedCodeInputAttemptCount: Int?
    var maximumCodeInputAttempts: Int?
}

struct UserDTO: Codable {
    var id: String
    var mobileAppID: String?
}

//
// Copyright (c) 2023-present The Collinson Group Limited. All Rights Reserved.
//

import Foundation

struct SignUpWithCodeDTO: Codable {
    var status: String
    var deviceId: String
    var flowType: String
    var preAuthSessionId: String
}

//
//  SignUpType.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import Foundation

public enum SignUpType: Equatable {
    case email(email: String)
    case phoneNumber(phoneNumber: String)
}

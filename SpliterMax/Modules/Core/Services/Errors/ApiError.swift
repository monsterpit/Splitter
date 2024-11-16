//
//  ApiError.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

public enum ApiError: Error {
    case defaultError(message: String, apiQuery: String? = nil)
    case noDataError(apiQuery: String? = nil)
    case signInFailed(message: String? = "Failed")
    case otpAttemptFailed(leftInputAttempts: Int)
    case otpAttemptLocked
    case tokenRevoked
    case logoutFailed
    case noInternet
    
    public var localizedDescription: String {
        errorMessage
    }
    
    private var errorMessage: String {
        switch self {
        case .defaultError(let message, _):
            message
        case .signInFailed(let message):
            message ?? ""
        case .noDataError:
            "no data error"
        default:
            String(describing: self)
        }
    }
    
    public var loggerMessage: String {
        switch self {
        case .defaultError(let message, let apiQuery):
            getLoggerErrorMessage(message: message, apiQuery: apiQuery)
        case .noDataError(let apiQuery):
            getLoggerErrorMessage(message: "no data error", apiQuery: apiQuery)
        case .signInFailed(let message):
            message ?? ""
        default:
            String(describing: self)
        }
    }
    
    private func getLoggerErrorMessage(message: String, apiQuery: String?) -> String {
        if let apiQuery {
            message + "\n\(apiQuery)"
        } else {
            message
        }
    }
}

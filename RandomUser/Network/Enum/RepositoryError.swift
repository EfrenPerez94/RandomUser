//
//  RepositoryError.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation

/// Handle possible repository errors
enum RepositoryError: Error {
    case dbUnavailable
    case unableToMakeRequest
    case failedParsing
    case dataIsNil
    /// Error 400
    case badRequest
    /// Error 401
    case unauthorized
    /// Error 403
    case forbidden
    /// Error 404
    case notFound
    /// Error 408
    case requestTimeout
    /// Error 429
    case tooManyRequest
    /// Error 500
    case internalServerError
}

extension RepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dbUnavailable:
            return "Could not read data from DB"
        case .unableToMakeRequest:
            return "Something happened - Unable to make request."
        case .failedParsing:
            return "Something happened - Failed parsing"
        case .dataIsNil:
            return "Something happened - Data is nil"
        case .badRequest:
            return "Error 400 - Bad request."
        case .unauthorized:
            return "Error 401 - Unauthorized."
        case .forbidden:
            return "Error 403 - Forbidden."
        case .notFound:
            return "Error 404 - Not found."
        case .requestTimeout:
            return "Error 408 - Request timeout."
        case .tooManyRequest:
            return "Error 429 - Too many request."
        case .internalServerError:
            return "Error 500 - Internal server error."
        }
    }
}

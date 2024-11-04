//
//  APError.swift
//  Coins-iOS
//
//  Created by Aya Mahmoud on 15/09/2024.
//

import Foundation

enum APError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(_ code: Int)
    case unknownError(description: String)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .jsonParsingFailure: return "Failed To Parse JSON"
        case .invalidStatusCode(let code): return "Failed with code \(code)"
        case let .requestFailed(description): return "Request Failed \(description)"
        case let .unknownError(description): return "Unknown Error \(description)"
        }
    }
}

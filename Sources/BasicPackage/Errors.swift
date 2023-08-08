//
//  Errors.swift
//
//  Created by Adarsh Sharma on 28/07/23.
//

public enum Errors: Error {
    case invalidData
    case apiError(message: String)
    
    var displayMessage: String {
        switch self {
        case .invalidData:
            return "API Data invalid"
        case .apiError(let message):
            return message
        }
    }
}

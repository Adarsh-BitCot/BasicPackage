//
//  Errors.swift
//
//  Created by Adarsh Sharma on 28/07/23.
//

public enum Errors: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case apiError(message: String)
    
    var displayMessage: String {
        switch self {
        case .invalidResponse:
            return ""
        case .invalidURL:
            return ""
        case .invalidData:
            return "Data invalid"
        case .network(let error):
            return error?.localizedDescription ?? ""
        case .apiError(let message):
            return message
        }
    }
}

enum NetworkResponseState {
    case success(Any)
    case error(Errors)
}

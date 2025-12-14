//
//  APIError.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation

enum APIError: LocalizedError {
    case invaliedURL, invaliedResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invaliedURL:
            return "The URL is invalied"
        case .invaliedResponse:
            return "Invalied response from server"
        case .decoding(let error):
            return "Failed to decode response \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error \(error.localizedDescription)"
        }
    }
}

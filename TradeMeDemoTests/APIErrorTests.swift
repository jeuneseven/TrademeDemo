//
//  APIErrorTests.swift
//  TradeMeDemoTests
//
//  Created by seven on 2025/12/12.
//

import Testing
import Foundation
@testable import TradeMeDemo

@Suite("APIError Tests")
struct APIErrorTests {
    
    @Test("Invalid URL error has correct description")
    func invalidURLErrorDescription() {
        let error = APIError.invaliedURL
        #expect(error.errorDescription == "The URL is invalied")
    }
    
    @Test("Invalid response error has correct description")
    func invalidResponseErrorDescription() {
        let error = APIError.invaliedResponse
        #expect(error.errorDescription == "Invalied response from server")
    }
    
    @Test("Decoding error description contains expected text")
    func decodingErrorDescription() {
        let underlyingError = NSError(domain: "DecodingError", code: 1, userInfo: nil)
        let error = APIError.decoding(underlyingError)
        let description = error.errorDescription ?? ""
        #expect(description.contains("Failed to decode response"))
    }
    
    @Test("Network error description contains expected text")
    func networkErrorDescription() {
        let underlyingError = URLError(.networkConnectionLost)
        let error = APIError.networkError(underlyingError)
        let description = error.errorDescription ?? ""
        #expect(description.contains("Network error"))
    }
    
    @Test("Error conforms to LocalizedError")
    func errorConformsToLocalizedError() {
        let error: Error = APIError.invaliedURL
        #expect(error is LocalizedError)
    }
    
    @Test("All error cases have descriptions", arguments: [
        APIError.invaliedURL,
        APIError.invaliedResponse,
        APIError.decoding(NSError(domain: "test", code: 1, userInfo: nil)),
        APIError.networkError(URLError(.unknown))
    ])
    func allErrorCasesHaveDescriptions(error: APIError) {
        #expect(error.errorDescription != nil)
    }
}


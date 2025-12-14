//
//  MockDiscoverService.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation

/// Mock service for testing that loads sample data from SampleData.json
struct MockDiscoverService: DiscoverService {
    func fetchList() async throws -> LatestListResponse {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invaliedURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(LatestListResponse.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.invaliedResponse
        }
    }
}

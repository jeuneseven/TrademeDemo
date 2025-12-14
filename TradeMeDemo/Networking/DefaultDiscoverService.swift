//
//  DefaultDiscoverService.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation

struct DefaultDiscoverService: DiscoverService {
    func fetch<T: Decodable>(from urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invaliedURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            // Build OAuth 1.0 PLAINTEXT signature header
            let oauthHeader = "OAuth oauth_consumer_key=\(Constants.Network.oauthConsumerKey),oauth_signature_method=\(Constants.Network.oauthSignatureMethod),oauth_signature=\(Constants.Network.oauthSignature)&"
            request.setValue(oauthHeader, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Log response for debugging (remove in production)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON:\n\(jsonString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invaliedResponse
            }
            
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    func fetchList() async throws -> LatestListResponse {
        let url = Constants.Network.baseURL + Constants.Network.listingsEndpoint + "?rows=\(Constants.Network.defaultRowCount)"
        return try await fetch(from: url, type: LatestListResponse.self)
    }
}

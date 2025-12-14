//
//  DiscoverApi.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation

protocol DiscoverService: Sendable {
    func fetchList() async throws -> LatestListResponse
}

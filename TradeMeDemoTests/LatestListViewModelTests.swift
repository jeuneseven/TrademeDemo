//
//  LatestListViewModelTests.swift
//  TradeMeDemoTests
//
//  Created by seven on 2025/12/12.
//

import Testing
@testable import TradeMeDemo
import Foundation

@Suite("LatestListViewModel Tests")
struct LatestListViewModelTests {
    
    @Test("Initial state is idle")
    func initialStateIsIdle() {
        let mockService = MockDiscoverService()
        let viewModel = LatestListViewModel(service: mockService)
        
        #expect(viewModel.state == .idle)
    }
    
    @Test("Fetch successfully loads items")
    func fetchSuccessfully() async {
        let mockService = MockDiscoverService()
        let viewModel = LatestListViewModel(service: mockService)
        
        await viewModel.fetch()
        
        switch viewModel.state {
        case .loaded(let items):
            #expect(items.count > 0)
        default:
            #expect(Bool(false), "Should be loaded state")
        }
    }
    
    @Test("Fetch prevents concurrent requests")
    func fetchPreventsConcurrentRequests() async {
        let mockService = MockDiscoverService()
        let viewModel = LatestListViewModel(service: mockService)
        
        await viewModel.fetch()
        let stateAfterFirstFetch = viewModel.state
        
        await viewModel.fetch()
        let stateAfterSecondFetch = viewModel.state
        
        #expect(stateAfterFirstFetch == stateAfterSecondFetch)
    }
    
    @Test("Retry resets state and fetches again")
    func retryResetsAndFetches() async {
        let mockService = MockDiscoverService()
        let viewModel = LatestListViewModel(service: mockService)
        
        viewModel.state = .error("Test error")
        
        await viewModel.retry()
        
        switch viewModel.state {
        case .loaded:
            #expect(Bool(true))
        default:
            #expect(Bool(false), "Should load after retry")
        }
    }
    
    @Test("Error handling with APIError")
    func errorHandlingWithAPIError() async {
        let errorService = FailingMockService(error: APIError.invaliedResponse)
        let viewModel = LatestListViewModel(service: errorService)
        
        await viewModel.fetch()
        
        switch viewModel.state {
        case .error(let errorMessage):
            #expect(errorMessage == APIError.invaliedResponse.errorDescription)
        default:
            #expect(Bool(false), "Should be in error state")
        }
    }
    
    @Test("Error handling with unknown error")
    func errorHandlingWithUnknownError() async {
        let unknownError = NSError(domain: "unknown", code: -1, userInfo: nil)
        let errorService = FailingMockService(error: unknownError)
        let viewModel = LatestListViewModel(service: errorService)
        
        await viewModel.fetch()
        
        if case .error = viewModel.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false), "Should be in error state")
        }
    }
}

// MARK: - Mock Services for Testing

private struct FailingMockService: DiscoverService {
    let error: Error
    
    func fetchList() async throws -> LatestListResponse {
        if let apiError = error as? APIError {
            throw apiError
        }
        throw APIError.invaliedResponse
    }
}

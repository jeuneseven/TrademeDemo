//
//  LatestListViewModel.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation
import Observation

@Observable
class LatestListViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([LatestListItem])
        case error(String)
    }
    
    var state: State = .idle
    
    private let service: DiscoverService
    
    init(service: DiscoverService = DefaultDiscoverService()) {
        self.service = service
    }

    /// Fetch the latest listings from the service
    /// Prevents multiple concurrent requests by checking current state
    func fetch() async {
        // Avoid fetching too many times
        guard state == .idle else { return }
        state = .loading
        do {
            let response = try await service.fetchList()
            self.state = .loaded(response.list)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? Constants.Strings.errorLoadingListings)
        } catch {
            self.state = .error(Constants.Strings.errorLoadingListings)
        }
    }
    
    /// Retry fetching listings by resetting state to idle
    func retry() async {
        state = .idle
        await fetch()
    }
}

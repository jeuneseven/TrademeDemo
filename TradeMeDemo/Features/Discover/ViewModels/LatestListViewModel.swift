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
    
    // UI Text Constants
    let navigationTitle = "Browse"
    let searchAlertTitle = "Search"
    let searchImage = "magnifyingglass"
    let searchAccessibilityIdentifier = "searchButton"
    let searchAccessibilityLabel = "Search listings"
    let cartAlertTitle = "Shopping cart"
    let cartImage = "cart"
    let cartAccessibilityIdentifier = "cartButton"
    let cartAccessibilityLabel = "Shopping cart"
    let listItemAccessibilityHint = "Double tap to view listing details"
    let listingDetailsAlertTitle = "Listing Details"
    
    // Loading State Constants
    let loadingMessage = "Loading listings..."
    let loadingStackSpacing: CGFloat = 16
    let loadingProgressScale: CGFloat = 1.5
    
    // Error State Constants
    let errorTitle = "Failed to load listings"
    let errorImageName = "exclamationmark.triangle.fill"
    let errorImageSize: CGFloat = 48
    let errorStackSpacing: CGFloat = 16
    let errorViewPadding: CGFloat = 20
    let retryButtonText = "Try Again"
    let retryButtonTopPadding: CGFloat = 16
    let buttonVerticalPadding: CGFloat = 12
    
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

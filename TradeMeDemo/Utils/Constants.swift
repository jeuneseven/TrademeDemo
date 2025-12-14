//
//  Constants.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation
import SwiftUI

struct Constants {
    // MARK: - Design System
    struct Design {
        // Padding and Spacing
        static let listItemHorizontalPadding: CGFloat = 16
        static let listItemHorizontalSpacing: CGFloat = 12
        static let listItemVerticalSpacing: CGFloat = 6
        static let listItemPriceSpacing: CGFloat = 4
        static let listItemVerticalPadding: CGFloat = 12
        
        // Image
        static let listItemImageSize: CGFloat = 120
        static let listItemImageCornerRadius: CGFloat = 8
        
        // Corner Radius
        static let buttonCornerRadius: CGFloat = 8
        
        // Opacity
        static let subtleTextOpacity: Double = 0.6
    }
    
    // MARK: - Strings
    struct Strings {
        // Navigation
        static let navigationTitle = "Browse"
        static let searchAccessibilityLabel = "Search listings"
        static let cartAccessibilityLabel = "Shopping cart"
        
        // Tab Titles
        static let discoverTab = "Discover"
        static let notificationsTab = "Notifications"
        static let watchlistTab = "Watchlist"
        static let myTradeMeTab = "My Trade Me"
        
        // Latest Listings
        static let loadingMessage = "Loading listings..."
        static let noContentMessage = "No content yet"
        static let errorLoadingListings = "Failed to load listings"
        
        // Placeholder Messages
        static let notificationsPlaceholder = "Notifications"
        static let watchlistPlaceholder = "Watchlist"
        static let myTradeMePlaceholder = "My Trade Me"
        
        // Price Display
        static let buyNowPrefix = "Buy Now: "
        static let untitledListing = "Untitled"
        static let contactForPrice = "Contact for price"
        static let noPrice = "No price"
        
        // Accessibility
        static let listingRowAccessibility = "Listing"
    }
    
    // MARK: - Network
    struct Network {
        static let baseURL = "https://api.tmsandbox.co.nz"
        static let listingsEndpoint = "/v1/listings/latest.json"
        static let defaultRowCount = 20
        
        // OAuth 1.0 Credentials (for sandbox)
        static let oauthConsumerKey = "A1AC63F0332A131A78FAC304D007E7D1"
        static let oauthSignature = "EC7F18B17A062962C6930A8AE88B16C7"
        static let oauthSignatureMethod = "PLAINTEXT"
    }
    
    // MARK: - Currency
    struct Currency {
        static let defaultCode = "NZD"
        static let defaultSymbol = "$"
    }
    
    // MARK: - Colors (Trade Me Brand Colors)
    struct Colors {
        // Tasman Blue (#148FE2)
        static let tasmanBlue = Color(red: 0x14/255, green: 0x8F/255, blue: 0xE2/255)
        // Feijoa Green (#29A754)
        static let feijoaGreen = Color(red: 0x29/255, green: 0xA7/255, blue: 0x54/255)
        // Text Dark - Bluff Oyster 800 (#393531)
        static let textDark = Color(red: 0x39/255, green: 0x35/255, blue: 0x31/255)
        // Test Light - Bluff Oyster 600 (#85807B)
        static let textLight = Color(red: 0x85/255, green: 0x80/255, blue: 0x7B/255)
    }
}

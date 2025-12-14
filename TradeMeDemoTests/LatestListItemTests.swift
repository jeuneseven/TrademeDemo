//
//  LatestListItemTests.swift
//  TradeMeDemoTests
//
//  Created by seven on 2025/12/12.
//

import Testing
import Foundation
@testable import TradeMeDemo

@Suite("LatestListItem Tests")
struct LatestListItemTests {
    
    // MARK: - Helper function
    private func createTestItem(
        listingId: Int = 123,
        title: String? = "Test Item"
    ) -> LatestListItem {
        LatestListItem(
            listingId: listingId,
            title: title,
            category: nil,
            startPrice: nil,
            buyNowPrice: nil,
            startDate: nil,
            endDate: nil,
            categoryPath: nil,
            pictureHref: nil,
            region: nil,
            suburb: nil,
            priceDisplay: nil,
            isNew: nil,
            hasBuyNow: nil,
            isBuyNowOnly: nil,
            hasPayNow: nil,
            reserveState: nil,
            asAt: nil,
            noteDate: nil,
            promotionId: nil,
            memberId: nil,
            isFeatured: nil,
            hasGallery: nil,
            isBold: nil,
            isHighlighted: nil,
            hasHomePageFeature: nil,
            maxBidAmount: nil,
            bidCount: nil,
            isReserveMet: nil,
            hasReserve: nil,
            isClassified: nil
        )
    }
    
    // MARK: - Identifiable Tests
    
    @Test("Identifiable id equals listingId")
    func identifiableIdEqualsListingId() {
        let item = createTestItem(listingId: 456)
        #expect(item.id == 456)
        #expect(item.id == item.listingId)
    }
    
    // MARK: - Codable Tests
    
    @Test("Decoding JSON creates valid item")
    func decodingJSON() throws {
        let json = """
        {
            "ListingId": 789,
            "Title": "Test Item",
            "Region": "Auckland",
            "PriceDisplay": "$100.00"
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let item = try decoder.decode(LatestListItem.self, from: data)
        #expect(item.listingId == 789)
        #expect(item.title == "Test Item")
        #expect(item.region == "Auckland")
        #expect(item.priceDisplay == "$100.00")
    }
    
    // MARK: - Hashable Tests
    
    @Test("Items with same listingId are equal")
    func itemsWithSameListingIdAreEqual() {
        let item1 = createTestItem(listingId: 123)
        let item2 = createTestItem(listingId: 123)
        
        #expect(item1 == item2)
    }
    
    @Test("Items can be used in Set")
    func itemsCanBeUsedInSet() {
        let item1 = createTestItem(listingId: 123)
        let item2 = createTestItem(listingId: 123)
        
        let itemSet: Set = [item1, item2]
        #expect(itemSet.count == 1)
    }
}

// MARK: - LatestListResponse Tests

@Suite("LatestListResponse Tests")
struct LatestListResponseTests {
    
    @Test("Decoding JSON creates response with items")
    func decodingJSON() throws {
        let json = """
        {
            "List": [
                {
                    "ListingId": 123,
                    "Title": "Item 1"
                },
                {
                    "ListingId": 456,
                    "Title": "Item 2"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(LatestListResponse.self, from: data)
        #expect(response.list.count == 2)
        #expect(response.list[0].listingId == 123)
        #expect(response.list[1].listingId == 456)
    }
    
    @Test("Decoding empty list works")
    func decodingEmptyList() throws {
        let json = """
        {
            "List": []
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(LatestListResponse.self, from: data)
        #expect(response.list.isEmpty)
    }
}

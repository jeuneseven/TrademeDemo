//
//  Test.swift
//  TradeMeDemoTests
//
//  Created by seven on 2025/12/12.
//

import Testing
@testable import TradeMeDemo

@Suite("LatestListItemViewModel Tests")
struct LatestListItemViewModelTests {
    
    // MARK: - Helper
    private func createAuctionItem(
        title: String? = "Test Item",
        region: String? = "Auckland",
        priceDisplay: String? = "$100.00",
        buyNowPrice: Double? = nil,
        hasBuyNow: Bool? = false,
        isClassified: Bool? = false,
        pictureHref: String? = nil
    ) -> LatestListItem {
        LatestListItem(
            listingId: 123,
            title: title,
            category: nil,
            startPrice: nil,
            buyNowPrice: buyNowPrice,
            startDate: nil,
            endDate: nil,
            categoryPath: nil,
            pictureHref: pictureHref,
            region: region,
            suburb: nil,
            priceDisplay: priceDisplay,
            isNew: nil,
            hasBuyNow: hasBuyNow,
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
            isClassified: isClassified
        )
    }
    
    // MARK: - Title Tests
    
    @Test("Title displays correctly")
    func titleDisplaysCorrectly() {
        let item = createAuctionItem(title: "iPhone 13 Pro")
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.titleText == "iPhone 13 Pro")
    }
    
    @Test("Title falls back to untitled")
    func titleFallback() {
        let item = createAuctionItem(title: nil)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.titleText == Constants.Strings.untitledListing)
    }
    
    // MARK: - Location Tests
    
    @Test("Location displays correctly")
    func locationDisplaysCorrectly() {
        let item = createAuctionItem(region: "Wellington")
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.locationText == "Wellington")
    }
    
    @Test("Location is nil when no region")
    func locationNilWhenNoRegion() {
        let item = createAuctionItem(region: nil)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.locationText == nil)
    }
    
    // MARK: - Price Display Tests
    
    @Test("Auction price display shows correctly")
    func auctionPriceDisplay() {
        let item = createAuctionItem(priceDisplay: "$450.00", isClassified: false)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.priceDisplay == "$450.00")
    }
    
    @Test("Classified price display shows contact for price")
    func classifiedPriceDisplay() {
        let item = createAuctionItem(priceDisplay: nil, isClassified: true)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.priceDisplay == Constants.Strings.contactForPrice)
    }
    
    @Test("No price display shows correctly")
    func noPriceDisplay() {
        let item = createAuctionItem(priceDisplay: nil, isClassified: false)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.priceDisplay == Constants.Strings.noPrice)
    }
    
    // MARK: - Buy Now Price Tests
    
    @Test("Buy Now price should display when conditions met")
    func buyNowPriceShouldDisplay() {
        let item = createAuctionItem(
            buyNowPrice: 500.00, hasBuyNow: true,
            isClassified: false
        )
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.shouldShowBuyNowPrice == true)
        #expect(viewModel.buyNowPriceText == "Buy Now: $500.00")
    }
    
    @Test("Buy Now price should not display when zero")
    func buyNowPriceShouldNotDisplayWhenZero() {
        let item = createAuctionItem(
            buyNowPrice: 0, hasBuyNow: true,
            isClassified: false
        )
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.shouldShowBuyNowPrice == false)
    }
    
    @Test("Buy Now price should not display when classified")
    func buyNowPriceShouldNotDisplayWhenClassified() {
        let item = createAuctionItem(
            buyNowPrice: 500.00, hasBuyNow: true,
            isClassified: true
        )
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.shouldShowBuyNowPrice == false)
    }
    
    @Test("Buy Now price formatted with 2 decimals")
    func buyNowPriceFormatting() {
        let item = createAuctionItem(
            buyNowPrice: 123.4, hasBuyNow: true,
            isClassified: false
        )
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.buyNowPriceText == "Buy Now: $123.40")
    }
    
    // MARK: - Image URL Tests
    
    @Test("Image URL created correctly from pictureHref")
    func imageURLCreatedCorrectly() {
        let item = createAuctionItem(pictureHref: "https://example.com/image.jpg")
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.imageURL != nil)
        #expect(viewModel.imageURL?.absoluteString == "https://example.com/image.jpg")
    }
    
    @Test("Image URL is nil when no pictureHref")
    func imageURLNilWhenNoPictureHref() {
        let item = createAuctionItem(pictureHref: nil)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.imageURL == nil)
    }
    
    // MARK: - Classification Tests
    
    @Test("isClassified correctly identifies classified items")
    func isClassified() {
        let item = createAuctionItem(isClassified: true)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.isClassified == true)
    }
    
    @Test("isClassified defaults to false")
    func isClassifiedDefaultsFalse() {
        let item = createAuctionItem(isClassified: nil)
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.isClassified == false)
    }
    
    // MARK: - Layout Constants Tests
    
    @Test("Layout constants use Design constants")
    func layoutConstantsAreConsistent() {
        let item = createAuctionItem()
        let viewModel = LatestListItemViewModel(item: item)
        
        #expect(viewModel.imageSize == Constants.Design.listItemImageSize)
        #expect(viewModel.imageCornerRadius == Constants.Design.listItemImageCornerRadius)
        #expect(viewModel.horizontalSpacing == Constants.Design.listItemHorizontalSpacing)
    }
}

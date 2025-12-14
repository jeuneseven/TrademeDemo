//
//  LatestListItem.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import Foundation

struct LatestListResponse: Codable {
    let list: [LatestListItem]
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }
}

struct LatestListItem: Codable, Hashable, Equatable, Identifiable {
    var id: Int { listingId }
    let listingId: Int
    let title: String?
    let category: String?
    let startPrice: Double?
    let buyNowPrice: Double?
    let startDate: String?
    let endDate: String?
    let categoryPath: String?
    let pictureHref: String?
    let region: String?
    let suburb: String?
    let priceDisplay: String?
    let isNew: Bool?
    let hasBuyNow: Bool?
    let isBuyNowOnly: Bool?
    let hasPayNow: Bool?
    let reserveState: Int?
    let asAt: String?
    let noteDate: String?
    let promotionId: Int?
    let memberId: Int?
    let isFeatured: Bool?
    let hasGallery: Bool?
    let isBold: Bool?
    let isHighlighted: Bool?
    let hasHomePageFeature: Bool?
    let maxBidAmount: Double?
    let bidCount: Int?
    let isReserveMet: Bool?
    let hasReserve: Bool?
    let isClassified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case listingId = "ListingId"
        case title = "Title"
        case category = "Category"
        case startPrice = "StartPrice"
        case buyNowPrice = "BuyNowPrice"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case categoryPath = "CategoryPath"
        case pictureHref = "PictureHref"
        case region = "Region"
        case suburb = "Suburb"
        case priceDisplay = "PriceDisplay"
        case isNew = "IsNew"
        case hasBuyNow = "HasBuyNow"
        case isBuyNowOnly = "IsBuyNowOnly"
        case hasPayNow = "HasPayNow"
        case reserveState = "ReserveState"
        case asAt = "AsAt"
        case noteDate = "NoteDate"
        case promotionId = "PromotionId"
        case memberId = "MemberId"
        case isFeatured = "IsFeatured"
        case hasGallery = "HasGallery"
        case isBold = "IsBold"
        case isHighlighted = "IsHighlighted"
        case hasHomePageFeature = "HasHomePageFeature"
        case maxBidAmount = "MaxBidAmount"
        case bidCount = "BidCount"
        case isReserveMet = "IsReserveMet"
        case hasReserve = "HasReserve"
        case isClassified = "IsClassified"
    }
}

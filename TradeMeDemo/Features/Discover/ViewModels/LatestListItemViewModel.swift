//
//  LatestListItemViewModel.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/12.
//

import Foundation
import SwiftUI

class LatestListItemViewModel {
    // MARK: - Layout Constants
    let imageSize: CGFloat = Constants.Design.listItemImageSize
    let imageCornerRadius: CGFloat = Constants.Design.listItemImageCornerRadius
    let horizontalSpacing: CGFloat = Constants.Design.listItemHorizontalSpacing
    let verticalSpacing: CGFloat = Constants.Design.listItemVerticalSpacing
    let priceSpacing: CGFloat = Constants.Design.listItemPriceSpacing
    let rowVerticalPadding: CGFloat = Constants.Design.listItemVerticalPadding
    let horizontalPadding: CGFloat = Constants.Design.listItemHorizontalPadding
    
    // MARK: - Image Constants
    let placeholderImageName = "photo"
    
    // MARK: - Colors
    let buyNowPriceColor = Constants.Colors.tasmanBlue
    let subtleTextOpacity: Double = Constants.Design.subtleTextOpacity
    
    // MARK: - Data
    let item: LatestListItem
    
    init(item: LatestListItem) {
        self.item = item
    }
    
    // MARK: - Computed Properties
    
    /// Get the primary image URL from the listing
    var imageURL: URL? {
        guard let pictureHref = item.pictureHref else { return nil }
        return URL(string: pictureHref)
    }
    
    /// Get the location display text
    var locationText: String? {
        item.region
    }
    
    /// Get the title with fallback
    var titleText: String {
        item.title ?? Constants.Strings.untitledListing
    }
    
    /// Determine if this is a classified listing
    var isClassified: Bool {
        item.isClassified ?? false
    }
    
    /// Get the price display based on listing type
    var priceDisplay: String {
        item.priceDisplay ?? (isClassified ? Constants.Strings.contactForPrice : Constants.Strings.noPrice)
    }
    
    /// Check if Buy Now price should be displayed (auction only, has buy now, and price > 0)
    var shouldShowBuyNowPrice: Bool {
        !isClassified &&
        (item.hasBuyNow ?? false) &&
        (item.buyNowPrice ?? 0) > 0
    }
    
    /// Get formatted Buy Now price string
    var buyNowPriceText: String {
        guard let price = item.buyNowPrice else { return "" }
        return "\(Constants.Strings.buyNowPrefix)\(Constants.Currency.defaultSymbol)\(String(format: "%.2f", price))"
    }
    
    /// Get the title line limit for truncation
    var titleLineLimit: Int {
        2
    }
}

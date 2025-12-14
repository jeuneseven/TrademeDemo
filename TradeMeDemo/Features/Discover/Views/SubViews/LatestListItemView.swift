//
//  LatestListItemView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct LatestListItemView: View {
    let viewModel: LatestListItemViewModel
    
    var body: some View {
        HStack(spacing: viewModel.horizontalSpacing) {
            imageSection
            contentSection
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, viewModel.rowVerticalPadding)
        .padding(.horizontal, viewModel.horizontalPadding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(Constants.Strings.listingRowAccessibility): \(viewModel.titleText), \(viewModel.priceDisplay)")
    }
    
    // MARK: - Image Section
    private var imageSection: some View {
        Group {
            if let imageURL = viewModel.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .empty:
                        loadingPlaceholder
                    case .failure:
                        fallbackImage
                    default:
                        loadingPlaceholder
                    }
                }
                .frame(width: viewModel.imageSize, height: viewModel.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: viewModel.imageCornerRadius))
            } else {
                placeholderImage
            }
        }
        .accessibilityHidden(true)
    }
    
    private var loadingPlaceholder: some View {
        RoundedRectangle(cornerRadius: viewModel.imageCornerRadius)
            .fill(Constants.Colors.textLight.opacity(0.1))
            .frame(width: viewModel.imageSize, height: viewModel.imageSize)
            .overlay {
                ProgressView()
            }
    }
    
    private var fallbackImage: some View {
        Image(systemName: viewModel.placeholderImageName)
            .foregroundStyle(Constants.Colors.textLight)
    }
    
    private var placeholderImage: some View {
        RoundedRectangle(cornerRadius: viewModel.imageCornerRadius)
            .fill(Constants.Colors.textLight.opacity(0.1))
            .frame(width: viewModel.imageSize, height: viewModel.imageSize)
            .overlay {
                fallbackImage
            }
    }
    
    // MARK: - Content Section
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: viewModel.verticalSpacing) {
            // Location
            if let location = viewModel.locationText {
                Text(location)
                    .font(.caption)
                    .foregroundStyle(Constants.Colors.textLight)
                    .opacity(viewModel.subtleTextOpacity)
            }
            
            // Title
            Text(viewModel.titleText)
                .font(.headline)
                .foregroundStyle(Constants.Colors.textDark)
                .lineLimit(viewModel.titleLineLimit)
            
            Spacer()
            
            // Price Section
            priceSection
        }
    }
    
    private var priceSection: some View {
        VStack(alignment: .leading, spacing: viewModel.priceSpacing) {
            // Current price or asking price
            Text(viewModel.priceDisplay)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Constants.Colors.textDark)
            
            // Buy Now price (auction only)
            if viewModel.shouldShowBuyNowPrice {
                Text(viewModel.buyNowPriceText)
                    .font(.caption)
                    .foregroundStyle(viewModel.buyNowPriceColor)
            }
        }
    }
}

#Preview {
    let sampleData = loadSampleData()
    if let firstItem = sampleData?.list.first {
        return LatestListItemView(viewModel: LatestListItemViewModel(item: firstItem))
    } else {
        return Text("Failed to load sample data")
    }
}

// MARK: - Helper function to load sample data
private func loadSampleData() -> LatestListResponse? {
    guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
        print("SampleData.json not found")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(LatestListResponse.self, from: data)
    } catch {
        print("Failed to decode SampleData.json: \(error)")
        return nil
    }
}

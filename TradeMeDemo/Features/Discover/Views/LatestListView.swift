//
//  LatestListView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct LatestListView: View {
    @State private var listViewModel = LatestListViewModel()
    @State private var showingPlaceholderAlert = false
    @State private var placeholderAlertTitle = ""
    @State private var selectedListingTitle = ""
    
    var body: some View {
        NavigationStack {
            Group {
                switch listViewModel.state {
                case .idle, .loading:
                    loadingView
                case .loaded(let list):
                    loadedView(list)
                case .error(let error):
                    errorView(error)
                }
            }
            .navigationTitle(Constants.Strings.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    searchButton
                    cartButton
                }
            }
            .alert(placeholderAlertTitle, isPresented: $showingPlaceholderAlert) {
                Button("OK") { }
            } message: {
                if placeholderAlertTitle == "Listing Details" {
                    Text("You tapped on: \(selectedListingTitle)")
                } else if placeholderAlertTitle == "Search" {
                    Text("Search functionality coming soon")
                } else if placeholderAlertTitle == "Shopping Cart" {
                    Text("Shopping cart functionality coming soon")
                } else {
                    Text("Feature coming soon")
                }
            }
        }
        .task {
            await listViewModel.fetch()
        }
    }
    
    // MARK: - Loading State
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5, anchor: .center)
            Text(Constants.Strings.loadingMessage)
                .foregroundStyle(Constants.Colors.textLight)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Loaded State
    private func loadedView(_ list: [LatestListItem]) -> some View {
        List(list) { item in
            Button {
                selectedListingTitle = item.title ?? "Unknown"
                placeholderAlertTitle = listViewModel.listingDetailsAlertTitle
                showingPlaceholderAlert = true
            } label: {
                LatestListItemView(viewModel: LatestListItemViewModel(item: item))
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(listViewModel.listItemAccessibilityHint)
        }
        .listStyle(.plain)
    }
    
    // MARK: - Error State
    private func errorView(_ errorMessage: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: listViewModel.errorImageName)
                .font(.system(size: listViewModel.errorImageSize))
                .foregroundStyle(Constants.Colors.tasmanBlue)
            
            Text(listViewModel.errorTitle)
                .font(.headline)
                .foregroundStyle(Constants.Colors.textDark)
            
            Text(errorMessage)
                .font(.subheadline)
                .foregroundStyle(Constants.Colors.textLight)
                .multilineTextAlignment(.center)
            
            Button {
                Task {
                    await listViewModel.retry()
                }
            } label: {
                Text(listViewModel.retryButtonText)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, listViewModel.buttonVerticalPadding)
                    .background(Constants.Colors.tasmanBlue)
                    .cornerRadius(Constants.Design.buttonCornerRadius)
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Toolbar Buttons
    private var searchButton: some View {
        Button {
            placeholderAlertTitle = listViewModel.searchAlertTitle
            showingPlaceholderAlert = true
        } label: {
            Image(systemName: listViewModel.searchImage)
                .accessibilityIdentifier(listViewModel.searchAccessibilityIdentifier)
                .accessibilityLabel(listViewModel.searchAccessibilityLabel)
        }
    }

    private var cartButton: some View {
        Button {
            placeholderAlertTitle = listViewModel.cartAlertTitle
            showingPlaceholderAlert = true
        } label: {
            Image(systemName: listViewModel.cartImage)
                .accessibilityIdentifier(listViewModel.cartAccessibilityIdentifier)
                .accessibilityLabel(listViewModel.cartAccessibilityLabel)
        }
    }
}

#Preview {
    LatestListView()
        .environment(LatestListViewModel(service: MockDiscoverService()))
}

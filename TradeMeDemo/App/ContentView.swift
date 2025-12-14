//
//  ContentView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Discover"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Discover", image: "search", value: "Discover") {
                LatestListView()
            }
            
            Tab("Notifications", systemImage: "bell", value: "Notifications") {
                OtherTabView(tab: .notifications)
            }
            
            Tab("Watchlist", image: "watchlist", value: "Watchlist") {
                OtherTabView(tab: .watchlist)
            }
            
            Tab("My Trade Me", image: "profile-16", value: "My Trade Me") {
                OtherTabView(tab: .mytrademe)
            }
        }
    }
}

#Preview {
    ContentView()
}

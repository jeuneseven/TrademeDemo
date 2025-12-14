//
//  ContentView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = Constants.Strings.discoverTab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(Constants.Strings.discoverTab,
                image: Constants.Design.discoverTabImage,
                value: Constants.Strings.discoverTab) {
                LatestListView()
            }
            
            Tab(Constants.Strings.notificationsTab,
                systemImage: Constants.Design.notificationTabImage,
                value: Constants.Strings.notificationsTab) {
                OtherTabView(tab: .notifications)
            }
            
            Tab(Constants.Strings.watchlistTab,
                image: Constants.Design.watchlistTabImage,
                value: Constants.Strings.watchlistTab) {
                OtherTabView(tab: .watchlist)
            }
            
            Tab(Constants.Strings.myTradeMeTab,
                image: Constants.Design.myTradeMeTabImage,
                value: Constants.Strings.myTradeMeTab) {
                OtherTabView(tab: .mytrademe)
            }
        }
    }
}

#Preview {
    ContentView()
}

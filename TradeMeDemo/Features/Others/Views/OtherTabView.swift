//
//  OtherTabView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct OtherTabView: View {
    enum TabType {
    case notifications, watchlist, mytrademe
    }
    
    let tab: TabType
    
    var title: String {
        switch tab {
        case .notifications:
            Constants.Strings.notificationsTab
        case .watchlist:
            Constants.Strings.watchlistTab
        case .mytrademe:
            Constants.Strings.myTradeMeTab
        }
    }
    
    var body: some View {
        NavigationStack {
            EmptyView()
                .navigationTitle(title)
        }
    }
    
    init(tab: TabType) {
        self.tab = tab
    }
}

#Preview {
    OtherTabView(tab: .watchlist)
}

//
//  EmptyView.swift
//  TradeMeDemo
//
//  Created by seven on 2025/12/11.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No content", systemImage: "swift")
        } description: {
            Text("no content yet")
        } actions: {
            Button("create a content") {
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    EmptyView()
}

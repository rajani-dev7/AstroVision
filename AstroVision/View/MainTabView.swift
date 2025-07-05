//
//  MainTabView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import SwiftUI

/// The main tab-based navigation view for the app.
/// Contains two tabs: one for today's APOD and one for browsing by date.
struct MainTabView: View {
    var body: some View {
        TabView {
            // Tab 1: Shows today's Astronomy Picture of the Day
            APODView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
            
            // Tab 2: Allows users to pick a specific date to view APOD
            APODDateContentView(viewModel: APODViewModel())
                .tabItem {
                    Label("Browse", systemImage: "calendar")
                }
        }
        .ignoresSafeArea(.all, edges: .bottom) // Extends content to the bottom screen edge
    }
}

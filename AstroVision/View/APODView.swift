//
//  APODView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation
import SwiftUI

/// The main view that loads and displays today's Astronomy Picture of the Day (APOD).
/// It uses `APODContentView` inside a `NavigationView` and fetches data on appear.
struct APODView: View {
    @StateObject var viewModel = APODViewModel()  // ViewModel that handles fetching APOD data
    var body: some View {
        NavigationView {
            APODContentView(viewModel: viewModel)
            .navigationTitle("Astronomy Picture")  // Set title for navigation bar
            .onAppear {
                Task {
                    try await viewModel.fetchAPOD()  // Fetch today's APOD when the view appears
                }
            }
        }
    }
}

#Preview {
    APODView()
}

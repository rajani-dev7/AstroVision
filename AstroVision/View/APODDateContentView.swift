//
//  APODDate+ContentView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import SwiftUI

/// A view that shows a date picker initially, and then displays APOD content for the selected date.
/// Allows the user to pick a new date and refetch the content.
struct APODDateContentView: View {
    @StateObject var viewModel: APODViewModel
    @State var date: Date = Date()    // Selected date
    @State var isDataFetched = false  // Tracks if data has been loaded for the selected date
    
    var body: some View {
        VStack {
            if self.isDataFetched {
                // Show APOD content and fetch new date button
                APODContentView(viewModel: viewModel)
                fetchButton
            } else {
                // Show date picker and "Load APOD" button
                VStack {
                    DatePicker("Select Date", selection: $date, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .frame(maxWidth: 300)
                    
                    Spacer()
                    
                    Button("Load APOD") {
                        Task {
                            try? await viewModel.fetchAPOD(for: date.getString())
                            self.isDataFetched = true
                        }
                    }
                    .primaryButtonStyle()
                    .padding(.bottom, 24)
                }
            }
        }
        .padding(.bottom, 20)
        .adaptiveBackground()
        .onDisappear {
            // Reset fetch flag when view disappears
            self.isDataFetched = false
        }
    }
    
    /// Button shown after content is loaded to allow user to pick a new date
    var fetchButton: some View {
        Button("Fetch Content for New Date") {
            self.isDataFetched = false
        }
        .primaryButtonStyle()
        .padding(.bottom, 12)
    }
}

#Preview {
    APODDateContentView(viewModel: APODViewModel())
}

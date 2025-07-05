//
//  APODContentView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import SwiftUI

/// Displays the content of the APOD (Astronomy Picture of the Day).
/// Shows title, media (image/video), explanation, or error/loading state.
struct APODContentView: View {
    @StateObject var viewModel: APODViewModel
    var body: some View {
        ScrollView {
            if let apod = viewModel.apod {
                // Show APOD content
                VStack(spacing: 12) {
                    
                    // Title and date in a horizontal layout
                    HStack(alignment: .top) {
                        Text(apod.title)
                            .font(.headline)
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Text(apod.date)
                            .font(.subheadline)
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Display image or video based on media type
                    MediaView(mediaType: apod.mediaType, url: apod.url)
                    
                    // APOD explanation text
                    Text(apod.explanation)
                        .font(.body)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                // Show error message if fetching fails
                Text(error)
                    .foregroundColor(.primary)
                    .font(.body)
            } else {
                // Show a loading indicator while fetching
                ProgressView()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom) //Extend content to bottom
        .adaptiveBackground() // Apply system background for light/dark mode
    }
}

#Preview {
    APODContentView(viewModel: APODViewModel())
}

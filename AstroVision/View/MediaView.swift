//
//  MediaView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import SwiftUI

/// Displays either an image or a video depending on the media type.
/// For images, it fetches and displays from a URL.
/// For videos, it embeds a WebView (e.g., YouTube link).
struct MediaView: View {
    var mediaType: MediaType
    var url: String
    @StateObject var viewModel = MediaViewModel()
    
    var body: some View {
        Group {
            switch mediaType {
            case .image:
                VStack {
                    if let data = viewModel.imageData,
                        let uiImage = UIImage(data: data) {
                        // Show image if data is available and valid
                         Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        // Show a loading spinner while image loads
                         ProgressView()
                    }
                }
            case .video:
                if let videoURL = URL(string: url) {
                    // Display embedded video using WebView
                    WebView(url: videoURL)
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(12)
                } else {
                    // Fallback text if URL is invalid
                    Text("Invalid video URL")
                        .foregroundColor(.primary)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            // Start fetching image on view appear
            viewModel.fetchImage(from: url)
        }
        .onChange(of: url) { newValue in
            // Refetch image if URL changes
            viewModel.fetchImage(from: newValue)
        }
    }
}


#Preview {
    MediaView(mediaType: .image, url: "")
}

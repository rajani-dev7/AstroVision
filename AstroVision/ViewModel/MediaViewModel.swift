//
//  MediaViewModel.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// ViewModel responsible for fetching image data from a URL.
/// Used when the APOD media is of type .image
@MainActor
class MediaViewModel: ObservableObject {
    @Published var imageData: Data?
    
    /// Fetches image data asynchronously from a given URL string.
    /// Sets the result to  imageData , which updates the UI.
    func fetchImage(from url: String) {
        self.imageData = nil
        Task {
            self.imageData = try? await ImageURLService().fetchImage(from: url)
        }
    }
}

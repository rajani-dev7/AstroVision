//
//  APODViewModel.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// ViewModel responsible for managing the state of APOD content.
/// It handles fetching the data (from cache or API) and exposing it to the UI.
@MainActor
class APODViewModel: ObservableObject {
    @Published var apod: APOD?   // Holds the fetched APOD data
    @Published var errorMessage: String? //Optional error message to show in UI
    
    var apodURLService = APODUrlService(urlConfigs: URLConfigurations.shared)

    /// Fetches the APOD content for a given date.
    /// - If cached data exists, it's shown immediately.
    /// - Always makes a network request in the background to update the latest content.
    /// - Updates the `apod` or sets `errorMessage` in case of failure.
    func fetchAPOD(for date: String? = nil) async throws {
        self.apod = nil // Reset current content
        
        // Load cached data first, if available
        if let data = apodURLService.fetchCachedResponse(for: date) {
            self.apod = data
        }
        // Always try to fetch latest data from the API
        do {
            let result = try await apodURLService.fetchApod(with: date)
            self.apod = result
        } catch {
            self.errorMessage = "Not able to fetch the content"
        }
    }
}



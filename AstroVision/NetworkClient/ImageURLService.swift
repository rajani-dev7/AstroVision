//
//  ImageURLService.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 02/07/2025.
//

import Foundation

/// A service class responsible for fetching image data from a given URL.
/// Inherits from `NetworkService`, which handles the actual HTTP request logic.
class ImageURLService: NetworkService {
    
    /// Attempts to fetch image data from a URL string.
    /// - If cached data exists, it returns that immediately.
    /// - Otherwise, it performs a network request to fetch the image data.
    /// - Parameter url: A string representing the image URL.
    /// - Returns: Image data (`Data`) or throws if the fetch fails.
    func fetchImage(from url: String) async throws -> Data? {
        // Check if the image is already cached and return if available
        if let cachedResponse = URL(string: url)?.cachedResponse.data {
            return cachedResponse
        }
        
        // Perform network request if no cache is available
        return try await self.fetchResponse(for: url).get() as? Data
    }
    
    /// Parses raw response data as-is since we're dealing with image bytes (not JSON).
    /// - Parameter responseData: The binary data returned from the image request.
    /// - Returns: A success result containing the raw `Data`.
    override func parseResponseData(_ responseData: Data) -> APIResult {
        return .success(responseData)
    }
}

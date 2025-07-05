//
//  APODUrlService.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// A network service responsible for fetching APOD data from the NASA API.
/// Inherits from `NetworkService`, which handles the underlying request logic.
class APODUrlService: NetworkService {
    
    var urlConfigs: URLConfigurations
    
    init(urlConfigs: URLConfigurations) {
        self.urlConfigs = urlConfigs
    }
    
    /// Fetches the APOD data for a specific date from the API.
    /// - Parameter date: A date string in the format "yyyy-MM-dd". If `nil`, today's date is used.
    /// - Returns: An optional `APOD` object.
    /// - Throws: `APIClientError.badUrl` if the URL is invalid, or any error from the network layer.
    func fetchApod(with date: String?) async throws -> APOD? {
        guard let url = urlConfigs.getUrl(with: date) else {
            throw APIClientError.badUrl
        }
        // Fetch response using the base class method and attempt to cast it as APOD
        return try await self.fetchResponse(for: url).get() as? APOD
    }
    
    /// Parses raw API response data into an `APOD` object.
    /// - Parameter responseData: The raw data returned from the network request.
    /// - Returns: A success with the decoded `APOD`, or failure with decoding error.
    override func parseResponseData(_ responseData: Data) -> APIResult {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(APOD.self, from: responseData)
            return .success(result)
        } catch {
            return .failure(APIClientError.decodingError)
        }
    }
    
    
    /// Retrieves a previously cached APOD response for a given date.
    /// - Parameter date: The date for which cached data is requested.
    /// - Returns: A cached `APOD` object if available, otherwise `nil`.
    func fetchCachedResponse(for date: String?) -> APOD? {
        guard let url = URLConfigurations.shared.getUrl(with: date) else {
            return nil
        }
        
        // Attempt to decode cached data directly using the same parsing logic
        if let data = url.cachedResponse.data,
            let result = try? self.parseResponseData(data).get() as? APOD {
            return result
        }
        return nil
    }
}

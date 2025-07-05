//
//  URLRequest+Extension.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

// MARK: - URLRequest Extension for Caching

extension URLRequest {
    
    /// Returns the cached response (if any) for this request.
    /// This includes both the original `URLResponse` and its associated  Data .
    var cachedResponse: (response: URLResponse?, data: Data?) {
        let cachedResponse = URLCache.shared.cachedResponse(for: self)
        return (cachedResponse?.response, cachedResponse?.data)
    }
    
    
    /// Stores a response and its data in the cache for this request.
    /// - Parameters:
    ///   - response: The URL response to be cached.
    ///   - data: The data received from the network call.
    func storeCache(response: URLResponse, data: Data) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: self)
    }
}

// MARK: - URL Extension to Support Caching Using Normalized URLRequest
extension URL {
    /// Returns the cached response for this URL (if available).
    /// It internally converts the URL to a normalized URLRequest without the API key.
    var cachedResponse: (response: URLResponse?, data: Data?) {
        self.normalizedRequest?.cachedResponse ?? (nil,nil)
    }
    
    /// Stores a response and its data in the cache for this URL.
    /// Internally uses a normalized URLRequest (without API key).
    /// - Parameters:
    ///   - response: The URL response to be cached.
    ///   - data: The data received from the network call.
    func storeCache(response: URLResponse, data: Data) {
        self.normalizedRequest?.storeCache(response: response, data: data)
    }
    
    /// Converts the URL to a `URLRequest` with the "api_key" query parameter removed.
    /// This ensures consistent cache keys regardless of the API key value.
    private var normalizedRequest: URLRequest? {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems?.removeAll { $0.name == "api_key" }
        guard let normalizedURL = components?.url else {
            return nil
        }
        return URLRequest(url: normalizedURL)
    }
}



//
//  APIClientError.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// Represents different types of errors that can occur while making API calls.
enum APIClientError: Error {
    case badUrl          // The URL provided was invalid or malformed
    case decodingError   // Failed to decode the response into the expected model
    case networkError    // A network-related issue occurred (e.g., no internet, timeout)
    case dataError       // The response didn't contain any usable data
    case authError       // The request was unauthorized or authentication failed
}

//
//  APOD.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// This struct represents the data model for NASA's Astronomy Picture of the Day (APOD).
/// It conforms to `Codable` so we can easily decode it from JSON.
struct APOD: Codable {
    let title: String            // The title of the image or video
    let explanation: String      // A detailed explanation of the content
    let url: String              // URL to the image or video
    let mediaType: MediaType     // Indicates whether it's an image or a video
    let date: String             // The date for which this APOD is fetched
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case url
        case mediaType = "media_type" // The actual JSON key is `media_type`
        case date
    }
}

// MARK: - Custom decoding logic to safely handle unknown or missing media types
extension APOD {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the basic string properties directly from the container
        self.title = try container.decode(String.self, forKey: .title)
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.url = try container.decode(String.self, forKey: .url)
        self.date = try container.decode(String.self, forKey: .date)
        
        // For mediaType, try to decode the raw string value first
        // If it's valid, use it, otherwise, default to .image
        if let type = try? container.decodeIfPresent(String.self, forKey: .mediaType),
            let mediaType = MediaType(rawValue: type) {
            self.mediaType = mediaType
        } else {
            self.mediaType  = .image
        }
    }
}

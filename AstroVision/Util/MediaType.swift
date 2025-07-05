//
//  MediaType.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// Represents the type of media returned by the APOD API.
/// Can be either an image or a video.
enum MediaType: String, Codable {
    case image
    case video
}

//
//  URLConfiguration.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import Foundation

/// A singleton class responsible for managing API configuration settings
/// loaded from a local JSON file (e.g., base URL and API key).
class URLConfigurations {
    
    static let shared = URLConfigurations()
    var urlConfigs: URLConfigs? // Holds decoded values from Config.json
    var fileName = "Config"
    
    private init() {
        self.fetchConfigs()
    }
    
    /// Loads the configuration data from the bundled `Config.json` file.
    /// If the file is missing or decoding fails, config remains nil.
    func fetchConfigs() {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            self.urlConfigs = try JSONDecoder().decode(URLConfigs.self, from: data)
        } catch {
            return
        }
    }
    
    /// Constructs a full API URL using the base URL, API key, and optional date.
    /// - Parameter date: A string in "yyyy-MM-dd" format. If nil, today’s date is used.
    /// - Returns: A complete `URL` object or `nil` if base URL is missing or malformed.
    func getUrl(with date: String?)-> URL? {
        guard let urlString = self.urlConfigs?.baseUrl else {
            return nil
        }
        var components = URLComponents(string: urlString)
        
        // Always include the API key
        let apiQueryItem: URLQueryItem = URLQueryItem(name: "api_key", value: self.urlConfigs?.apiKey)
        var queryItems = [URLQueryItem]()
        queryItems.append(apiQueryItem)
        
        // Add date parameter, use today’s date if none provided
        if let date {
            let dateQueryItem = URLQueryItem(name: "date", value: date)
            queryItems.append(dateQueryItem)
        } else {
            let dateQueryItem = Date().currentDateQueryItem
            queryItems.append(dateQueryItem)
        }
        components?.queryItems = queryItems
        return components?.url
    }
}

// MARK: - Date Extension for Formatting and Query Item Generation
extension Date {
    
    /// Returns the current date in "yyyy-MM-dd" format as a string.
    func getString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    /// Returns a URLQueryItem for today’s date with the key "date".
    var currentDateQueryItem: URLQueryItem {
        return URLQueryItem(name: "date", value: Date().getString())
    }
}

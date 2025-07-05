//
//  WebView.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import WebKit
import SwiftUI

/// A SwiftUI wrapper around `WKWebView` to display web content.
/// Accepts a `URL` and loads the corresponding web page.
struct WebView: UIViewRepresentable {
    let url: URL

    /// Creates and returns a new instance of  WKWebView.
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    /// Loads the provided URL into the web view whenever the view updates.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

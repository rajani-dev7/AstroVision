//
//  View+Extension.swift
//  AstroVision
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import SwiftUI

// MARK: - View Extension for Common Styling
extension View {
    /// Applies a background color that automatically adapts to light or dark mode.
    /// Uses the system's default background color.
    func adaptiveBackground() -> some View {
        self.background(Color(.systemBackground))
    }
    
    /// Applies a consistent style for primary buttons across the app.
    /// Includes padding, font, color, corner radius, and accent background.
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
}

// MARK: - Reusable Primary Button Modifier
struct PrimaryButtonStyle: ViewModifier {
    /// Defines the styling to be applied to any view acting as a primary button.
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

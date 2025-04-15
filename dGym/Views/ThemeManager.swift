//
//  ThemeManager.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import Foundation
import SwiftUI

// Define the theme
enum AppTheme: String {
    case light, dark
}

//Store the current theme in AppStorage to persist it
class ThemeManager: ObservableObject {
    // Default to system appearance, but save the user's choice in AppStorage
    @AppStorage("selectedTheme") private var selectedTheme: String?

    // A computed property to access the current theme
    var currentTheme: AppTheme {
        get {
            // Default to system appearance if no user selection is found
            if let theme = selectedTheme {
                return AppTheme(rawValue: theme) ?? .light
            } else {
                return .light // Default to light theme
            }
        }
        set {
            selectedTheme = newValue.rawValue
        }
    }
    // Helper to toggle between light and dark themes
    func toggleTheme() {
        currentTheme = (currentTheme == .light) ? .dark : .light
    }
}

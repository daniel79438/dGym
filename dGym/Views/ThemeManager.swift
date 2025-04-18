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
    
    let accentColor = Color(red: 1.0, green: 0.84, blue: 0.0) // Yellow accent
    let darkBackground = Color.black
    let lightBackground = Color.white
    
    // A computed property to access the current theme
    var currentTheme: AppTheme {
        get {
            // Default to system appearance if no user selection is found
            if let theme = selectedTheme {
                return AppTheme(rawValue: theme) ?? .dark
            } else {
                return .dark // Default to dark theme
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
    
    var backgroundColor: Color {
        currentTheme == .dark ? .black : .white
    }
    
    var textColor: Color {
        currentTheme == .dark ? .white : .black
    }
    
    var secondaryTextColor: Color {
        currentTheme == .dark ? .gray : .gray
    }
}

//
//  dGymApp.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

import SwiftUI
import SwiftData

@main
struct dGymApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.currentTheme == .light ? .light : .dark)
        }
        .modelContainer(ModelContainer.shared)
    }
}

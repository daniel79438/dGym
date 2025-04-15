//
//  RootView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var themeManager = ThemeManager()
    @State private var flipRotation: Double = 0
    
    var body: some View {
        NavigationStack {
            WorkoutTypeSelectionView()
                .preferredColorScheme(themeManager.currentTheme == .light ? .light : .dark)
                .navigationTitle("Choose a Workout")
                .font(.largeTitle)
                .padding(.top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                flipRotation += 180
                                themeManager.toggleTheme()
                            }
                        }) {
                            ZStack {
                                Image(systemName: "moon.fill")
                                    .opacity(themeManager.currentTheme == .light ? 1 : 0)
                                    .rotation3DEffect(.degrees(flipRotation), axis: (x: 0, y: 1, z: 0))
                                    .foregroundColor(.black)
                                
                                Image(systemName: "sun.max.fill")
                                    .opacity(themeManager.currentTheme == .dark ? 1 : 0)
                                    .rotation3DEffect(.degrees(flipRotation + 180), axis: (x: 0, y: 1, z: 0))
                                    .foregroundColor(.yellow)
                            }
                            .padding()
                    }
                }
            }
        }
        .environmentObject(themeManager)
    }
}

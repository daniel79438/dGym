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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Workout.self, Exercise.self, ExerciseSet.self])
    }
}

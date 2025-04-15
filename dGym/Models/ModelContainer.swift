//  ModelContainer.swift
//  dGym
//  Created by Daniel Harris on 15/04/2025.

import SwiftUI
import SwiftData

class AppModelContainer {
    static var shared = AppModelContainer()
    
    let container: ModelContainer
    
    private init() {
        let schema = Schema([
            Workout.self,
            Exercise.self,
            ExerciseSet.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            DefaultExercises(context: ModelContext(container))
        } catch {
            fatalError("😡 FATAL ERROR: Could not create ModelContainer: \(error)")
        }
    }
}

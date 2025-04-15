//  ModelContainer.swift
//  dGym
//  Created by Daniel Harris on 15/04/2025.

import SwiftData

extension ModelContainer {
    static var shared: ModelContainer = {
        let schema = Schema([
            Workout.self,
            Exercise.self,
            ExerciseSet.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // Fix: Create a computed property that returns a ModelContext for this container
    var mainContext: ModelContext {
        return ModelContext(self)
    }
}

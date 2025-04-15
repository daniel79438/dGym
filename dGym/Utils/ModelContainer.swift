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
            fatalError("😡 FATAL ERROR: Could not create ModelContainer: \(error)")
        }
    }()
    
    var mainContext: ModelContext {
        return ModelContext(self)
    }
}

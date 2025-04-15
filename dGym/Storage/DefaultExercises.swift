//
//  DefaultExercises.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import Foundation
import SwiftData

func DefaultExercises(context: ModelContext) {
    guard !UserDefaults.standard.bool(forKey: "DefaultExercisesLoaded") else {
        return
    }
    
    let defaultExercises: [Exercise] = [
        Exercise(name: "Lat Raise", type: .upper),
        Exercise(name: "Overhead Press", type: .upper),
        Exercise(name: "Pull Ups", type: .upper),
        Exercise(name: "Curls", type: .upper),
        Exercise(name: "Rope Pulldowns", type: .upper),
        Exercise(name: "Face Pulls", type: .upper),
        Exercise(name: "Tricep Bar", type: .upper),
        Exercise(name: "Tricep Push Downs", type: .upper),
        Exercise(name: "Upright Rows", type: .upper),
        Exercise(name: "Lat Pulldowns", type: .upper),
        Exercise(name: "Leg Press", type: .lower),
        Exercise(name: "Leg Curl", type: .lower),
        Exercise(name: "Leg Extension", type: .lower),
        Exercise(name: "Calf Raise", type: .lower),
        Exercise(name: "Good Girl", type: .lower),
        Exercise(name: "Naughty Girl", type: .lower),
        Exercise(name: "Running", type: .cardio),
        Exercise(name: "Cross Trainer", type: .cardio),
        Exercise(name: "Cycling", type: .cardio),
        Exercise(name: "Rowing", type: .cardio)
    ]
    
    defaultExercises.forEach { context.insert($0) }
    
    try? context.save()
    UserDefaults.standard.set(true, forKey: "DefaultExercisesLoaded")
}

//
//  WorkoutViewModel.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI
import SwiftData

class WorkoutViewModel: ObservableObject {
    @Published var selectedWorkoutType: WorkoutType
    @Published var tempExercises: [Exercise] = []
    @Published var customExerciseName: String = ""
    
    private weak var modelContextRef: ModelContext?
    
    init(modelContext: ModelContext, initialType: WorkoutType = .upper) {
        self.modelContextRef = modelContext
        self.selectedWorkoutType = initialType
    }
    
    func addExerciseToWorkout(_ exercise: Exercise) {
        let set = ExerciseSet(reps: 6, weight: 50)
        let workoutExercise = Exercise(name: exercise.name, type: exercise.type, sets: [set])
        tempExercises.append(workoutExercise)
    }
    
    func addCustomExercise() {
        guard !customExerciseName.isEmpty, let modelContext = modelContextRef else { return }
        
        let newExercise = Exercise(name: customExerciseName, type: selectedWorkoutType)
        modelContext.insert(newExercise)
        
        let set = ExerciseSet(reps: 6, weight: 50)
        let workoutExercise = Exercise(name: customExerciseName, type: selectedWorkoutType, sets: [set])
        tempExercises.append(workoutExercise)
        
        customExerciseName = ""
    }
    
    func saveWorkout() {
        guard let modelContext = modelContextRef else { return }
        
        let newWorkout = Workout(type: selectedWorkoutType, exercises: tempExercises)
        modelContext.insert(newWorkout)
        try? modelContext.save()
        
        tempExercises = []
    }
}

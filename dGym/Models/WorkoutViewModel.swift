//
//  WorkoutViewModel.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI
import SwiftData

class WorkoutViewModel: ObservableObject {
    @Published var selectedWorkoutType: WorkoutType = .upper
    @Published var tempExercises: [Exercise] = []
    @Published var customExerciseName: String = ""
    @Published var selectedExercise: Exercise?
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
          self.modelContext = modelContext
          loadDefaultExercises()
      }
    
    func loadDefaultExercises() {
         DefaultExercises(context: modelContext)
     }
    
    func addExerciseToWorkout(_ exercise: Exercise) {
        let set = ExerciseSet(reps: 8, weight: 50)
        let workoutExercise = Exercise(name: exercise.name, type: exercise.type, sets: [set])
        tempExercises.append(workoutExercise)
    }
    
    func addCustomExercise() {
        guard !customExerciseName.isEmpty else { return }
         
         let newExercise = Exercise(name: customExerciseName, type: selectedWorkoutType)
         modelContext.insert(newExercise)
         
         let set = ExerciseSet(reps: 8, weight: 50)
         let workoutExercise = Exercise(name: customExerciseName, type: selectedWorkoutType, sets: [set])
         tempExercises.append(workoutExercise)
         
         customExerciseName = ""
     }
    
    func saveWorkout() {
        let newWorkout = Workout(type: selectedWorkoutType, exercises: tempExercises)
        modelContext.insert(newWorkout)
        try? modelContext.save()
        
        // Reset temporary state
        tempExercises = []
    }
}

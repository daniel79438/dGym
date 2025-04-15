//
//  WorkoutListView.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

import SwiftUI
import SwiftData

// Define the AddWorkoutView struct
struct AddWorkoutView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let preselectedType: WorkoutType // This is the workout type selected on the previous screen
    @State private var selectedType: WorkoutType // A state property to hold the selected workout type, initially set to the preselectedType.

    
    @Environment(\.modelContext) private var modelContext // Access the model context for saving data to the database (SwiftData).
    @Environment(\.dismiss) private var dismiss // Allows the view to dismiss itself once the workout is saved.

    @Query var availableExercises: [Exercise]
    @State private var selectedExerciseName: String = ""
    @State private var isAddingCustomExercise: Bool = false
    @State private var customExerciseName: String = ""
    @State private var tempExercises: [Exercise] = []

    // Custom init to pass the preselected workout type from the previous screen.
    init(preselectedType: WorkoutType) {
        self.preselectedType = preselectedType
        // Set the selectedType to be the preselected type received.
        _selectedType = State(initialValue: preselectedType)
    }

    // The body of the view, where all the UI components are defined.
    var body: some View {
        Form { // Form that will contain all the UI elements
            // Picker to allow the user to change the workout type.
            // Default value is preselectedType, which is passed from the previous scre
            Picker("Workout Type", selection: $selectedType) {
                // Loop through all workout types (upper, lower, cardio)
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    // Each option in the picker is a workout type (upper, lower, etc.)
                    Text(type.rawValue.capitalized)
                        .foregroundColor(Color.primaryTextColor)
                }
            }
            // Section to add and view exercises
            Section(header: Text("Add Exercise")) {
                Picker("Select Exercise", selection: $selectedExerciseName) {
                // Loop through the exercises added so far.
                    ForEach(availableExercises, id: \.self) { exercise in
                        Text(exercise.name).tag(exercise.name)
                    }
                    Text("Add Exercise").tag("Other")
                }
                .onChange(of: selectedExerciseName) {
                    isAddingCustomExercise = selectedExerciseName == "Other"
                }
                if isAddingCustomExercise {
                    TextField("Custom Exercise Name", text: $customExerciseName)
                }
                Button("Add Exercise") {
                    let nameToUse = isAddingCustomExercise ? customExerciseName : selectedExerciseName
                    guard !nameToUse.isEmpty else { return }
                    
                    if isAddingCustomExercise && !availableExercises.contains(where: { $0.name.lowercased() == nameToUse.lowercased() }) {
                        let newExercise = Exercise(name: nameToUse)
                        modelContext.insert(newExercise)
                    }
                    let set = ExerciseSet(reps: 6, weight: 50)
                    let exercise = Exercise(name: nameToUse, sets: [set])
                    tempExercises.append(exercise)
                    
                    selectedExerciseName = ""
                    customExerciseName = ""
                    isAddingCustomExercise = false
                }
            }
            // Button to save the workout.
            Button("Save Workout") {
                // Create a new Workout object with the selected type and exercises.
                let newWorkout = Workout(type: selectedType, exercises: tempExercises)
                // Insert the new workout into the model context (to save it).
                modelContext.insert(newWorkout)
                // Dismiss the view after saving.
                dismiss()
            }
        }
        // Set the navigation title based on the selected workout type.
        .navigationTitle("New \(selectedType.rawValue.capitalized) Workout")
        .background(Color.backgroundColor)
    }
}


#Preview {
    AddWorkoutView(preselectedType: .upper)
}

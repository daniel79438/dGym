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
    
    @State private var tempExercises: [Exercise] = [] // This holds the exercises that the user is adding in this workout session.


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
            Section(header: Text("Exercises")) {
                // Button to add a new exercise to the workout
                Button("Add Exercise") {
                    // Create a dummy exercise set to start with.
                    let set = ExerciseSet(reps: 10, weight: 50)
                    // Create a new exercise and add the set to it.
                    let exercise = Exercise(name: "Bench Press", sets: [set])
                    // Append the new exercise to the temporary list of exercises.
                    tempExercises.append(exercise)
                }
                
                // Loop through the exercises added so far.
                ForEach(tempExercises, id: \.self) { exercise in
                    VStack(alignment: .leading) {
                        // Display the exercise name (e.g., "Bench Press").
                        Text("Exercise: \(exercise.name)")
                        // Loop through all sets of the current exercise and display the reps and weight.
                        ForEach(exercise.sets, id: \.self) { set in
                            Text("Reps: \(set.reps), Weight: \(set.weight, specifier: "%.1f") kg")
                                .foregroundColor(Color.primaryTextColor)
                        }
                    }
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

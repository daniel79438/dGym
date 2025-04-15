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
    @Environment(\.modelContext) private var modelContext // Access the model context for saving data to the database (SwiftData).
    @Environment(\.dismiss) private var dismiss // Allows the view to dismiss itself once the workout is saved.

    @StateObject private var viewModel: WorkoutViewModel
    @State private var isAddingCustomExercise: Bool = false
    
    @Query var availableExercises: [Exercise]

    init(preselectedType: WorkoutType) {
        let viewModel = WorkoutViewModel(modelContext: AppModelContainer.shared.mainContext)
        viewModel.selectedWorkoutType = preselectedType
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Form {
            Section(header: Text("Workout Type")) {
                
                Picker("Type", selection: $viewModel.selectedWorkoutType) {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
                        // Each option in the picker is a workout type (upper, lower, etc.)
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section(header: Text("Exercises")) {
                ForEach(viewModel.tempExercises) { exercise in
                    ExerciseRow(exercise: exercise)
                }
                .onDelete(perform: deleteExercise)
            }
            
            Section(header: Text("Add Exercise")) {
                if !isAddingCustomExercise {
                    List {
                        ForEach(availableExercisesFiltered, id: \.self) { exercise in
                            Button(exercise.name) {
                                viewModel.addExerciseToWorkout(exercise)
                            }
                        }
                    }
                    
                    Button("Add Custom Exercise") {
                        isAddingCustomExercise = true
                    }
                } else {
                    TextField("Exercise Name", text: $viewModel.customExerciseName)
                        .autocapitalization(.words)
                    
                    HStack {
                        Button("Cancel") {
                            isAddingCustomExercise = false
                            viewModel.customExerciseName = ""
                        }
                        
                        Spacer()
                        
                        Button("Add") {
                            viewModel.addCustomExercise()
                            isAddingCustomExercise = false
                        }
                        .disabled(viewModel.customExerciseName.isEmpty)
                    }
                }
            }
            
            Section {
                Button("Save Workout") {
                    viewModel.saveWorkout()
                    dismiss()
                }
                .disabled(viewModel.tempExercises.isEmpty)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(viewModel.tempExercises.isEmpty ? Color.gray : Color.blue)
                .cornerRadius(10)
            }
        }
        .navigationTitle("New \(viewModel.selectedWorkoutType.rawValue.capitalized) Workout")
        .background(Color.backgroundColor)
    }
    
    private var availableExercisesFiltered: [Exercise] {
        availableExercises.filter { $0.type == viewModel.selectedWorkoutType }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        viewModel.tempExercises.remove(atOffsets: offsets)
    }
}


#Preview {
    AddWorkoutView(preselectedType: .upper)
}

//
//  WorkoutListView.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

//  AddWorkoutView.swift
//  dGym
//  Created by Daniel Harris on 14/04/2025.

import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel: WorkoutViewModel
    @State private var isAddingCustomExercise: Bool = false
    
    @Query var availableExercises: [Exercise]

    init(preselectedType: WorkoutType) {
        _viewModel = StateObject(wrappedValue: WorkoutViewModel(
            modelContext: AppModelContainer.shared.container.mainContext,
            initialType: preselectedType
        ))
    }

    var body: some View {
        Form {
            Section(header: Text("Workout Type")) {
                Picker("Type", selection: $viewModel.selectedWorkoutType) {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
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
                    ForEach(availableExercisesFiltered, id: \.id) { exercise in
                        Button(exercise.name) {
                            viewModel.addExerciseToWorkout(exercise)
                        }
                    }
                    
                    Button("Add Custom Exercise") {
                        isAddingCustomExercise = true
                    }
                } else {
                    TextField("Exercise Name", text: $viewModel.customExerciseName)
                        .textInputAutocapitalization(.words)
                    
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

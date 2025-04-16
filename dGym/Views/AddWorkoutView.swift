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
        let viewModel = WorkoutViewModel(modelContext: ModelContainer.shared.mainContext)
        viewModel.selectedWorkoutType = preselectedType
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            themeManager.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Workout Type Selector
                HStack {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
                        Button(action: {
                            viewModel.selectedWorkoutType = type
                        }) {
                            Text(type.rawValue.capitalized)
                                .fontWeight(.medium)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity)
                        }
                        .background(viewModel.selectedWorkoutType == type ? themeManager.accentColor : Color.gray.opacity(0.3))
                        .foregroundColor(viewModel.selectedWorkoutType == type ? .black : themeManager.textColor)
                        .cornerRadius(8)
                    }
                }
                .padding()
                
                // Exercise List
                List {
                    Section(header: Text("Exercises").foregroundColor(themeManager.accentColor)) {
                        ForEach(viewModel.tempExercises) { exercise in
                            ExerciseRow(exercise: exercise)
                                .listRowBackground(themeManager.backgroundColor)
                        }
                        .onDelete(perform: deleteExercise)
                    }
                    
                    Section(header: Text("Add Exercise").foregroundColor(themeManager.accentColor)) {
                        if !isAddingCustomExercise {
                            ForEach(availableExercisesFiltered, id: \.self) { exercise in
                                Button(exercise.name) {
                                    viewModel.addExerciseToWorkout(exercise)
                                }
                                .foregroundColor(themeManager.textColor)
                                
                            }
                            
                            Button("Add Custom Exercise") {
                                isAddingCustomExercise = true
                            }
                            .foregroundColor(themeManager.accentColor)
                        } else {
                            TextField("Exercise Name", text: $viewModel.customExerciseName)
                                .textInputAutocapitalization(.words)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            
                            HStack {
                                Button("Cancel") {
                                    isAddingCustomExercise = false
                                    viewModel.customExerciseName = ""
                                }
                                .foregroundColor(.red)
                                
                                Spacer()
                                
                                Button("Add") {
                                    viewModel.addCustomExercise()
                                    isAddingCustomExercise = false
                                }
                                .disabled(viewModel.customExerciseName.isEmpty)
                                .foregroundColor(themeManager.accentColor)
                            }
                        }
                    }
                    .listRowBackground(themeManager.backgroundColor)
                }
                .scrollContentBackground(.hidden)
                
                // Save Button
                Button("Save Workout") {
                    viewModel.saveWorkout()
                    dismiss()
                }
                .disabled(viewModel.tempExercises.isEmpty)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .padding()
                .background(viewModel.tempExercises.isEmpty ? Color.gray : themeManager.accentColor)
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle("New \(viewModel.selectedWorkoutType.rawValue.capitalized) Workout")
        .foregroundColor(themeManager.textColor)
    }
    
    private var availableExercisesFiltered: [Exercise] {
        availableExercises.filter { $0.type == viewModel.selectedWorkoutType }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        viewModel.tempExercises.remove(atOffsets: offsets)
    }
}

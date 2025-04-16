//
//  ExerciseRow.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct ExerciseRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var exercise: Exercise
    @State private var isExpanded: Bool = true
    @State private var editingSetIndex: Int? = nil
    @State private var isEditingReps: Bool = false
    @State private var isEditingWeight: Bool = false
    @State private var temporaryReps: Int = 6
    @State private var temporaryWeight: Double = 25
    
    private let weightOptions: [Double] = Array(stride(from: 0.0, to: 200.0, by: 2.5))
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(themeManager.textColor)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(themeManager.accentColor)
                }
                .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                ForEach(exercise.sets.indices, id: \.self) { index in
                    HStack {
                        Text("Set \(index + 1)")
                            .foregroundColor(themeManager.secondaryTextColor)
                        Spacer()
                        
                        Button(action: {
                            editingSetIndex = index
                            temporaryReps = exercise.sets[index].reps
                            isEditingReps = true
                        }) {
                            Text("\(exercise.sets[index].reps) reps")
                                .foregroundColor(themeManager.textColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(6)
                        }
                        
                        Text("@")
                            .foregroundColor(themeManager.textColor)
                        
                        Button(action: {
                            editingSetIndex = index
                            temporaryWeight = exercise.sets[index].weight
                            isEditingWeight = true
                        }) {
                            Text(String(format: "%.1f kg", exercise.sets[index].weight))
                                .foregroundColor(themeManager.textColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(6)
                        }
                    }
                        .padding(.vertical, 4)
                        .padding(.leading, 8)
                }
                
                Button(action: { addSet() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Set")
                    }
                    .foregroundColor(themeManager.accentColor)
                    .padding(.top, 5)
                    .padding(.leading, 8)
                }
            }
        }
        .padding(.vertical, 4)
        .sheet(isPresented: $isEditingReps) {
            if let index = editingSetIndex {
                VStack {
                    Text("Select Reps")
                        .font(.headline)
                        .padding()
                    
                    Picker("Reps", selection: $temporaryReps) {
                        ForEach(1...30, id: \.self) { rep in
                                Text("\(rep)")
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    HStack {
                        Button("Cancel") {
                            isEditingReps = false
                        }
                        .foregroundStyle(.red)
                        
                        Spacer()
                        
                        Button("Save") {
                            exercise.sets[index].reps = temporaryReps
                            try? modelContext.save()
                            isEditingReps = false
                        }
                        .foregroundColor(themeManager.accentColor)
                    }
                    .padding()
                }
                .presentationDetents([.medium])
                .presentationBackground(themeManager.backgroundColor)
            }
        }
        .sheet(isPresented: $isEditingWeight) {
            if let index = editingSetIndex {
                VStack {
                    Text("Select Weight (kg)")
                        .font(.headline)
                        .padding()
                    
                    Picker("Weight", selection: $temporaryWeight) {
                        ForEach(weightOptions, id: \.self) { weight in
                            Text(String(format: "%.1f", weight))
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    HStack {
                        Button("Cancel") {
                            isEditingReps = false
                        }
                        .foregroundStyle(.red)
                        
                        Spacer()
                        
                        Button("Save") {
                            exercise.sets[index].weight = temporaryWeight
                            try? modelContext.save()
                            isEditingWeight = false
                        }
                        .foregroundColor(themeManager.accentColor)
                    }
                    .padding()
                }
                .presentationDetents([.medium])
                .presentationBackground(themeManager.backgroundColor)
            }
        }
    }
    
    func addSet() {
        if let lastSet = exercise.sets.last {
            let newSet = ExerciseSet(reps: lastSet.reps, weight: lastSet.weight + 2.5)
            exercise.sets.append(newSet)
            try? modelContext.save()
        } else {
            let newSet = ExerciseSet(reps: 8, weight: 50)
            exercise.sets.append(newSet)
            try? modelContext.save()
        }
    }
}

#Preview {
    let exercise = Exercise(name: "Bench Press", type: .upper, sets: [ExerciseSet(reps: 10, weight: 100)])
    return ExerciseRow(exercise: exercise)
}

//
//  ExerciseRow.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct ExerciseRow: View {
    var exercise: Exercise
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(exercise.name)
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                ForEach(exercise.sets.indices, id: \.self) { index in
                    HStack {
                        Text("Set \(index + 1)")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(exercise.sets[index].reps) reps")
                        Text("@")
                        Text("\(Int(exercise.sets[index].weight))kg")
                    }
                    .padding(.leading)
                }
                
                Button("Add Set") {
                    // Create a copy of the previous set with a slightly higher weight
                    if let lastSet = exercise.sets.last {
                        let newSet = ExerciseSet(reps: lastSet.reps, weight: lastSet.weight + 2.5)
                        exercise.sets.append(newSet)
                    }
                }
                .padding(.top, 5)
                .padding(.leading)
            }
        }
    }
}

#Preview {
    let exercise = Exercise(name: "Bench Press", type: .upper)
    exercise.sets = [ExerciseSet(reps: 10, weight: 100)]
    return ExerciseRow(exercise: exercise)
}

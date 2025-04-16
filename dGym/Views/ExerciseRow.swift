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
    @State private var isExpanded: Bool = false
    
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
                        Text("\(exercise.sets[index].reps) reps")
                            .foregroundColor(themeManager.textColor)
                        Text("@")
                            .foregroundColor(themeManager.textColor)
                        Text("\(Int(exercise.sets[index].weight))kg")
                            .foregroundColor(themeManager.textColor)
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

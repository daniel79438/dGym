//
//  WorkoutDetailView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutDetailView: View {
    @ObservedObject var workout: Workout
    
    var body: some View {
        List {
            Section(header: Text("Workout Info")) {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(dateFormatter.string(from: workout.date))
                }
                
                HStack {
                    Text("Type")
                    Spacer()
                    Text(workout.type.rawValue.capitalized)
                }
            }
            
            Section(header: Text("Exercises")) {
                ForEach(workout.exercises) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            
                            Text("\(exercise.sets.count) sets")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }
                
            }
        }
        .navigationTitle("Workout Details")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

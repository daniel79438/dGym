//
//  WorkoutRow.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(dateFormatter.string(from: workout.date))
                        .font(.headline)
                    
                    Text("\(workout.type.rawValue.capitalized) + \(workout.exercises.count) exercises")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.backgroundColor.opacity(0.5))
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}


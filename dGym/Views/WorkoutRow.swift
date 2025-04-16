//
//  WorkoutRow.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let workout: Workout
    
    var body: some View {
        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(dateFormatter.string(from: workout.date))
                        .font(.headline)
                        .foregroundColor(themeManager.textColor)
                    
                    Text("\(workout.type.rawValue.capitalized) + \(workout.exercises.count) exercises")
                        .font(.subheadline)
                        .foregroundColor(themeManager.secondaryTextColor)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(themeManager.accentColor)
            }
            .padding()
            .background(themeManager.backgroundColor.opacity(0.7))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(themeManager.accentColor.opacity(0.3), lineWidth: 1)
            )
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


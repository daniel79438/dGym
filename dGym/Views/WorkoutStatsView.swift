//
//  WorkoutStatsView.swift
//  dGym
//
//  Created by Daniel Harris on 16/04/2025.
//

import SwiftUI
import SwiftData

struct WorkoutStatsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var workouts: [Workout]
    
    // Calculate totals
    private var totalSets: Int {
        workouts.flatMap { $0.exercises }.flatMap { $0.sets }.count
    }
    
    private var totalWeight: Double {
        workouts.flatMap { $0.exercises }.flatMap { $0.sets }.reduce(0) { $0 + $1.weight }
    }
    
    private var lastWeek: [Workout] {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return workouts.filter { $0.date >= oneWeekAgo }
    }
    
    private var lastWeekSets: Int {
        lastWeek.flatMap { $0.exercises }.flatMap { $0.sets }.count
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Today")
                .font(.title)
                .bold()
                .foregroundColor(themeManager.textColor)
            
            // Rest/Training Toggle
            VStack(spacing: 12) {
                ZStack {
                    HStack(spacing: 0) {
                        Text("Rest")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(themeManager.textColor)
                        
                        Text("Training")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(themeManager.accentColor)
                            .foregroundColor(.black)
                    }
                    .frame(height: 36)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                
                HStack(spacing: 20) {
                    // Workout statas
                    ProgressCircle(value: Double(lastWeekSets), total: 100, label: "S")
                    ProgressCircle(value: Double(workouts.count), total: 30, label: "W")
                    ProgressCircle(value: totalWeight / 1000, total: 50, label: "T")
                }
                
                Text("\(lastWeekSets) of 20 sets completed")
                    .font(.headline)
                    .foregroundColor(themeManager.textColor)
            }
            .padding()
            .background(themeManager.backgroundColor)
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .padding()
    }
}

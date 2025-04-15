//
//  WorkoutTypeSelectionView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI


struct WorkoutTypeSelectionView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var workouts: [Workout]

    var body: some View {
        ScrollView {
        VStack(spacing: 24) {
            ForEach(WorkoutType.allCases, id: \.self) { type in
                NavigationLink {
                    AddWorkoutView(preselectedType: type)
                } label: {
                    WorkoutTypeCard(type.type, count: workoutCount(for: type))
                }
                }
            }

        .padding()
            
            if !workouts.isEmpty {
                recentWorkoutsSection
            }
    }
        .background(Color.backgroundColor.opacity(0.1))
        .navigationTitle("dGym")
}
    
    private var recentWOrkoutsSection: some View {
        VStack(alignment: .leading) {
            Text("Recent Workouts")
                .font(.headline)
                .padding([.leading, .top])
            
            ForEach(recentWorkouts) { workout in
                WorkoutRow(workout: workout)
            }
        }
    }
    
    private var recentWorkouts: [Workout] {
        Array(workouts.sorted { $0.date > $1.date }.prefix(5))
    }

    private func workoutCount(for type: WorkoutType) -> Int {
        workouts.filter { $0.type == type }.count
    }
    
    private func workoutCount(for type: WorkoutType) -> Int {
        workouts.filter { $0.type == type }.count
    }
    }

    
    #Preview {
    WorkoutTypeSelectionView()
}

//
//  WorkoutTypeCard.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutTypeCard: View {
    @EnvironmentObject var themeManager: ThemeManager
    let type: WorkoutType
    let count: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(type.rawValue.capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(count) workouts")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: iconName)
                .font(.system(size: 30))
                .foregroundColor(themeManager.accentColor)
        }
        .padding()
        .background(themeManager.backgroundColor)
        .foregroundColor(themeManager.textColor)
        .cornerRadius(12)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(themeManager.accentColor.opacity(0.5), lineWidth: 1)
        )
    }
    
    private var iconName: String {
        switch type {
        case .upper:
            return "figure.strengthtraining.traditional"
        case.lower:
            return "figure.run"
        case.cardio:
            return "heart.circle"
        }
    }
}

#Preview {
    WorkoutTypeCard(type: .upper, count: 5)
}

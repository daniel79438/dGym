//
//  WorkoutTypeCard.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutTypeCard: View {
    let type: WorkoutType
    let count: Int
    
    init(type: WorkoutType, count: Int) {
        self.type = type
        self.count = count
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
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
        }
        .padding()
        .background(Color.backgroundColor.opacity(0.8))
        .foregroundColor(.primary)
        .cornerRadius(12)
        .shadow(radius: 2)
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

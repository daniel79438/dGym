//
//  WorkoutTypeSelectionView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI


struct WorkoutTypeSelectionView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 24) {
            ForEach(WorkoutType.allCases, id: \.self) { type in
                NavigationLink {
                    AddWorkoutView(preselectedType: type)
                } label: {
                    Text(type.rawValue.capitalized)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.backgroundColor.opacity(0.8))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WorkoutTypeSelectionView()
}

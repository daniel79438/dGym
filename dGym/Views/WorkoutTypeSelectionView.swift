//
//  WorkoutTypeSelectionView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct WorkoutTypeSelectionView: View {
    var body: some View {
        NavigationStack{
            VStack(spacing: 24) {
                Text("Choose Workout Type")
                    .font(.largeTitle)
                    .padding(.top)
                
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    NavigationLink {
                        AddWorkoutView(preselectedType: type)
                    } label: {
                        Text(type.rawValue.capitalized)
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutTypeSelectionView()
}

//
//  ExerciseDetailView.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        List {
            ForEach(exercise.sets.indices, id: \.self) { index in
                HStack{
                    Text("Set \(index + 1)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(exercise.sets[index].reps) reps")
                    Text("@")
                    Text("\(Int(exercise.sets[index].weight))kg")
                }
            }
        }
        .navigationTitle(exercise.name)
    }
}

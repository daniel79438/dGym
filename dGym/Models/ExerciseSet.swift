//
//  ExerciseSet.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

import Foundation
import SwiftData

@Model
class ExerciseSet {
    @Attribute(.unique) var id: UUID = UUID()
    var reps: Int
    var weight: Double
    
    init(reps: Int, weight: Double) {
        self.reps = reps
        self.weight = weight
    }
}

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
    var id: UUID
    var name: String
    var reps: Int
    var weight: Double
    
    init(id: UUID, name: String, reps: Int, weight: Double) {
        self.name = name
        self.id = id
        self.reps = reps
        self.weight = weight
    }
}

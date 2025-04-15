//
//  Exercise.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

import Foundation
import SwiftData


@Model
class Exercise {
    var name: String
    var sets: [ExerciseSet]
    var type: WorkoutType
    
    init(name: String, type: WorkoutType, sets: [ExerciseSet] = []) {
        self.name = name
        self.type = type
        self.sets = sets
    }
}

//
//  Workout.swift
//  dGym
//
//  Created by Daniel Harris on 14/04/2025.
//

import Foundation
import SwiftData

@Model
class Workout {
    var id: UUID
    var date: Date
    var type: WorkoutType
    var exercises: [Exercise]
    
    init(id: UUID, date: Date, type: WorkoutType, exercises: [Exercise]) {
        self.id = id
        self.date = date
        self.type = type
        self.exercises = exercises
    }
}


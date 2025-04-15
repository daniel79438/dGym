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
    var date: Date
    var type: WorkoutType
    var exercises: [Exercise]
    
    init(date: Date = .now, type: WorkoutType, exercises: [Exercise]) {
        self.date = date
        self.type = type
        self.exercises = exercises
    }
}


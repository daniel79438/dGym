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
    
    init(name: String, sets: [ExerciseSet] = []) {
        self.name = name
        self.sets = sets
    }
}

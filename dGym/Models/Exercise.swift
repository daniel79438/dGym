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
    var id: UUID
    var name: String
    var sets: [ExerciseSet]
    
    init(id: UUID, name: String, sets: [ExerciseSet]) {
        self.id = id
        self.name = name
        self.sets = sets
    }
}

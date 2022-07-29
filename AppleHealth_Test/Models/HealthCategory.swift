//
//  HealthCategory.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import Foundation

struct HealthCategory: Identifiable {
    
    var id: String
    var name: String
    var image: String
    
    static func allCategories() -> [HealthCategory] {
        return [
            HealthCategory(id: "activeEnergyBurned", name: "Burned Calories", image: "⚡️"),
            HealthCategory(id: "appleExerciseTime", name: "Exercise Time", image: "🏋️‍♂️"),
            HealthCategory(id: "distanceWalkingRunning", name: "Walking/Running", image: "🏃"),
            HealthCategory(id: "stepCount", name: "Step Count", image: "👣")
        ]
    }
    
}//End of struct

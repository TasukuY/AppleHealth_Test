//
//  HealthInfo.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import Foundation
import HealthKit

struct HealthInfo: Identifiable {
    
    let id = UUID()
    let stat: HKQuantity?
    let date: Date
    
}//End of struct

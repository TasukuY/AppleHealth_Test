//
//  DetailViewModel.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import Foundation
import HealthKit

final class DetailViewModel: ObservableObject {
    
    var healthCategory: HealthCategory
    var healthStore: HealthStore
    let measurementFormatter = MeasurementFormatter()

    @Published var stats = [HealthInfo]()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()
    
    init(healthCategory: HealthCategory, healthStore: HealthStore) {
        self.healthCategory = healthCategory
        self.healthStore = healthStore
        healthStore.requestHealthData(by: healthCategory.id) { healthStats in
            self.stats = healthStats
        }
    }
    
    
    //TODO: - Research on heartrate unit
    func value(from stat: HKQuantity?) -> (value: Int, desc: String) {
        guard let stat = stat else { return (0, "") }
        
        measurementFormatter.unitStyle = .long
                
        if stat.is(compatibleWith: .kilocalorie()) {
            let value = stat.doubleValue(for: .kilocalorie())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .meter()) {
            let value = stat.doubleValue(for: .mile())
            let unit = Measurement(value: value, unit: UnitLength.miles)
            return (Int(value), measurementFormatter.string(from: unit))
        } else if stat.is(compatibleWith: .count()) {
            let value = stat.doubleValue(for: .count())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .minute()) {
            let value = stat.doubleValue(for: .minute())
            return (Int(value), stat.description)
        }
        
        return (0, "")
    }
    
}//End of class

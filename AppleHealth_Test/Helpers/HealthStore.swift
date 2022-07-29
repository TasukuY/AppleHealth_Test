//
//  HealthStore.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import Foundation
import HealthKit

final class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    let allHealthTypes = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!
    ])
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {

        guard let healthStore = self.healthStore else { return completion(false) }
        
        //toShare is to write data, read is to read the data
        healthStore.requestAuthorization(toShare: [], read: allHealthTypes) { success, error in
            
            if let error = error {
                print("Error while requesting authtorization to share the health related data: \(error.localizedDescription)")
                completion(false)
            }
            
            completion(success)
        }
    }
    
    func requestHealthData(by category: String, completion: @escaping ([HealthInfo]) -> Void) {
        
        if let healthStore = self.healthStore,
           let healthType = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) {

            let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
            let anchorDate = Date.mondayAt12AM()
            let daily = DateComponents(day: 1)
            
            var healthInfoArray: [HealthInfo] = []
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

            self.query = HKStatisticsCollectionQuery(quantityType: healthType,
                                                     quantitySamplePredicate: predicate,
                                                     anchorDate: anchorDate,
                                                     intervalComponents: daily)
            if let query = query {
                query.initialResultsHandler = { query, statisticsCollection, error in
                    statisticsCollection?.enumerateStatistics(from: startDate, to: Date(), with: { statistics, stop in
                        let stat = HealthInfo(stat: statistics.sumQuantity(), date: statistics.startDate)
                        healthInfoArray.append(stat)
                    })
                    
                    completion(healthInfoArray)
                }
            
                healthStore.execute(query)
            }
        }
    }
    
    private func typeByCategory(category: String) -> HKQuantityTypeIdentifier {
        switch category {
            
        case "activeEnergyBurned":
            return .activeEnergyBurned
        case "appleExerciseTime":
            return .appleExerciseTime
        case "distanceWalkingRunning":
            return .distanceWalkingRunning
        case "stepCount":
            return .stepCount
        default:
            return .stepCount
        }
    }
    
}//End of class

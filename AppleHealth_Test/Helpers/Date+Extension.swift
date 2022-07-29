//
//  Date+Extension.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import Foundation

extension Date {
    
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
    
}//End of extension

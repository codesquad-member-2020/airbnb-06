//
//  DateManager.swift
//  Airbnb
//
//  Created by jinie on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct DateManager {
    
    private let calendar = Calendar.current
    private var months: [Int] = []
    
    func firstWeekday() -> Int {
        let component = calendar.dateComponents([.year, .month, .weekday], from: Date())
        let startOfMonth = calendar.date(from: component)
        let firstWeekday = calendar.dateComponents([.year, .month, .weekday], from: startOfMonth!)
        return firstWeekday.weekday! - 1
    }
    
    mutating func getCountOfMonths() -> [Int] {
        let thisMonth = calendar.dateComponents([.month], from: Date())
        for month in thisMonth.month!...12 {
            months.append(month)
        }
        return months
    }
    
    func getCountOfDays(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func getMonth(index: Int) -> Int {
        return months[index]
    }
}

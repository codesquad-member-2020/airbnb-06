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
    private lazy var nowComponents = calendar.dateComponents([.year, .month, .weekday], from: Date())

    mutating func firstWeekday(thisMonth: Int) -> Int {
        var component = nowComponents
        component.month! += thisMonth
        let thisMonthDate = calendar.date(from: component)
        let thisMonthComponents = calendar.dateComponents([.year, .month, .weekday], from: thisMonthDate!)
        return thisMonthComponents.weekday! - 1
    }
    
    mutating func monthsFromNowToDecember() -> [Int] {
        for month in nowComponents.month!...12 {
            months.append(month)
        }
        return months
    }
    
    mutating func countOfDays(year: Int, month: Int) -> Int {
        let date = calendar.date(from: nowComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    mutating func yearMonth(_ index: Int) -> (year: Int, month: Int) {
        return (nowComponents.year!, months[index])
    }
    
    func thisMonth(_ index: Int) -> Int {
        return months[index]
    }
}

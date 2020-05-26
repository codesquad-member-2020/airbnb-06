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
    private lazy var nowComponents = calendar.dateComponents([.year, .month, .weekday, .day], from: Date())

    mutating func firstWeekday(thisMonth: Int) -> Int {
        var component = nowComponents
        component.month! += thisMonth
        let thisMonthDate = calendar.date(from: component)
        let firstDateOfMonth = thisMonthDate?.firstDayOfMonth
        let thisMonthComponents = calendar.dateComponents([.year, .month, .weekday, .day], from: firstDateOfMonth!)
        
        return thisMonthComponents.weekday!
    }
    
    mutating func monthsFromNowToDecember() -> [Int] {
        guard months.count == 0 else { return months }
        for month in nowComponents.month!...12 {
            months.append(month)
        }
        print(months.count)
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
    
    mutating func today() -> Int {
        return nowComponents.day!
    }
    
    func thisMonth(_ index: Int) -> Int {
        return months[index]
    }
}

extension Date {
    var firstDayOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
}

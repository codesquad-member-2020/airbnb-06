//
//  DateManager.swift
//  Airbnb
//
//  Created by jinie on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct DateManager {
    
    let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    func firstWeekday() -> Int {
        let calendar = NSCalendar.current
        let now = Date()
        let component = calendar.dateComponents([.year, .month, .weekday], from: now)
        let startOfMonth = calendar.date(from: component)
        let firstWeekday = calendar.dateComponents([.year, .month, .weekday], from: startOfMonth!)
        return firstWeekday.weekday! - 1
    }
    
}

//
//  Duration.swift
//  Timepiece
//
//  Created by Naoto Kaneko on 2014/08/17.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import Foundation

// hskim: 강제로 그레고리안으로 하도록 바꿨다. 2016년 6월 1일 21:31
public struct AppCalendar {
    static let gregorian : NSCalendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian) ?? NSCalendar.currentCalendar()
}




prefix func - (duration: Duration) -> (Duration) {
    return Duration(value: -duration.value, unit: duration.unit)
}

public class Duration {
    public let value: Int
    public let unit: NSCalendarUnit
    private let calendar = AppCalendar.gregorian // hskim
    
    /**
        Initialize a date before a duration.
    */
    public var ago: NSDate {
        return ago(from: NSDate())
    }
    
    public func ago(from date: NSDate) -> NSDate {
        return calendar.dateByAddingDuration(-self, toDate: date, options: .SearchBackwards)!
    }
    
    /**
        Initialize a date after a duration.
    */
    public var later: NSDate {
        return later(from: NSDate())
    }
    
    public func later(from date: NSDate) -> NSDate {
        return calendar.dateByAddingDuration(self, toDate: date, options: .SearchBackwards)!
    }
    
    /**
        This conversion is deprecated in 0.4.1 and will be obsoleted in 0.5.0.
    
        This operation is performed under incorrect assumption that 1 month is always equal to 30 days.
    */
    public lazy var interval: NSTimeInterval = { [unowned self] in
        return self.unit.interval * NSTimeInterval(self.value)
    }()
    
    public init(value: Int, unit: NSCalendarUnit) {
        self.value = value
        self.unit = unit
    }
}

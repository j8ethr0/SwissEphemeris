//  Date+JulianDate.swift
//  SwissEphemeris
//
//  Created by Vincent Smithers on 13.04.20.
//

import Foundation
import CSwissEphemeris

extension Date {
    /// The Julian day number for a date.
    /// https://en.wikipedia.org/wiki/Julian_day
    public func julianDate() -> Double {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        guard let year = components.year,
              let month = components.month,
              let day = components.day,
              let hour = components.hour,
              let minute = components.minute
        else {
            return 0
        }
        let second: Double = Double(components.second ?? 0)
        let UT = Double(hour) + Double(minute)/60 + second/3600
        let jd = swe_julday(Int32(year), Int32(month), Int32(day), UT, Int32(SE_GREG_CAL)) // Corrected call
        return jd
    }

    public init(julianDay: Double) {
        var year: Int32 = 0
        var month: Int32 = 0
        var day: Int32 = 0
        var hour: Double = 0

        swe_revjul(julianDay, Int32(SE_GREG_CAL) , &year, &month, &day, &hour) //correct

        var comps = DateComponents()
        comps.year = Int(year)
        comps.month = Int(month)
        comps.day = Int(day)
        comps.hour = Int(hour)
        comps.minute = Int((hour - Double(Int(hour))) * 60)
        comps.second = Int((((hour - Double(Int(hour))) * 60) - Double(comps.minute!)) * 60)

        //this could return nil, so use the current date if it does:
        self = Calendar.current.date(from: comps) ?? Date()

    }
}

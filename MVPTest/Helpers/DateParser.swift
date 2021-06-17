//
//  DateParser.swift
//  MVPTest
//
//  Created by Bezdenezhnykh Sergey on 16.06.2021.
//

import Foundation

final class DateParser {
    private var calendarCache = [Int : Calendar]()
    private var components = DateComponents()
    
    private let year = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private let month = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private let day = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private let hour = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private let minute = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private let second = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    
    func parseIsoString(date string: String?) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = parse(date: string) {
           let dateString = dateFormatterGet.string(from: date)
            return dateString
        } else {
            return "-"
        }
    }
    
    private func parse(date string: String?) -> Date? {
        guard let NonNilString = string else {
            return nil
        }
        
        _ = withVaList([year, month, day, hour, minute,
                        second], { pointer in
                            vsscanf(NonNilString, "%d-%d-%dT%d:%d:%dZ", pointer)
                            
        })
        
        components.year = year.pointee
        components.minute = minute.pointee
        components.day = day.pointee
        components.hour = hour.pointee
        components.month = month.pointee
        components.second = second.pointee
        
        if let calendar = calendarCache[0] {
            return calendar.date(from: components)
        }
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        calendarCache[0] = calendar
        return calendar.date(from: components)
    }
    
    
}


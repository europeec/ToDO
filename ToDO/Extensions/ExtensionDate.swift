//
//  ExtensionDate.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 13.10.2021.
//

import Foundation

extension Date {
    static func startOfDay(at date: Date = Date()) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func endOfDay(at date: Date = Date()) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59
        return Calendar.current.date(byAdding: dateComponents, to: startOfDay(at: date))!
    }
    
    func getDayComponents() -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year], from: self)
    }
    
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMdd, HH:mm")

        return dateFormatter.string(from: self)
    }
}

extension DateComponents: Comparable {
    static public func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lday = lhs.day, let lmonth = lhs.month, let lyear = lhs.year else { return false }
        guard let rday = rhs.day, let rmonth = rhs.month, let ryear = rhs.year else { return false }

        if lyear < ryear {
            return true
        } else if lyear == ryear {
            if lmonth < rmonth {
                return true
            } else if lmonth == rmonth {
                return lday < rday
            } else {
                return false 
            }
        } else {
            return false
        }
    }
}

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
}

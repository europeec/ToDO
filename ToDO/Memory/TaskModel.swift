//
//  File.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 12.10.2021.
//

import Foundation
import RealmSwift

class Task: Object, Comparable {
    @objc dynamic var name: String!
    @objc dynamic var about: String?
    @objc dynamic var startDate: Date!
    @objc dynamic var endDate: Date!

    static func < (lhs: Task, rhs: Task) -> Bool {
        return lhs.startDate < rhs.startDate
    }

    public func getTableIndexAtTask() -> ClosedRange<Int> {
        let startHour = Calendar.current.component(.hour, from: self.startDate)
        let endHour = Calendar.current.component(.hour, from: self.endDate)

        return startHour...endHour
    }
}

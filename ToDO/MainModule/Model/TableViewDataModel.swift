//
//  TableViewDataModel.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 15.10.2021.
//

import Foundation

// Section == 1 hour
struct SectionData {
    var title = ""
    var tasks: [Task]?
    
    init(index: Int, tasks: [Task]?) {
        self.title = getTitleForIndex(index)
        self.tasks = tasks
    }

    private func getTitleForIndex(_ index: Int) -> String {
        if index != 23 {
            if index < 9 {
                return "0\(index):00 - 0\(index + 1):00"
            } else if index == 9 {
                return "09:00 - 10:00"
            } else {
                return "\(index):00 - \(index + 1):00"
            }

        } else {
            return "23:00 - 00:00"
        }
    }
}

struct TableModel {
    var sections: [SectionData]
    var firstIndex = 23

    init(tasks: [Task]) {
        var sectionDict = [Int: [Task]]()
        var sections = [SectionData]()

        for task in tasks {
            let range = task.getTableIndexAtTask()
            for index in range {
                if sectionDict[index] == nil {
                    sectionDict[index] = [task]
                } else {
                    sectionDict[index]!.append(task)
                }

                firstIndex = min(index, firstIndex)
            }
        }

        for index in 0...23 {
            sections.append(SectionData(index: index, tasks: sectionDict[index]))
        }

        self.sections = sections
    }
}

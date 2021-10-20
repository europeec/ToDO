//
//  MemoryManager.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 09.10.2021.
//

import Foundation
import RealmSwift

protocol MemoryManagerProtocol: AnyObject {
    func save(task: Task)
    func fetchTasks(at date: Date) -> [Task]?
}

class MemoryManager: MemoryManagerProtocol {
    lazy var realm = try? Realm()

    func save(task: Task) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error {
            print(error)
        }
    }

    func fetchTasks(at date: Date) -> [Task]? {
        guard let realm = realm else { return nil }
        let objects = realm.objects(Task.self)
        return Array(objects).filter { filter(date: date, object: $0) }
    }

    private func filter(date: Date, object: Task) -> Bool {
        return date.getDayComponents() >= object.startDate.getDayComponents() && date.getDayComponents() <= object.endDate.getDayComponents()
    }
}

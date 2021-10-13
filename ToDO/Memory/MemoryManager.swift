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
    func fetchTasks() -> [Task]?
}

class MemoryManager: MemoryManagerProtocol {
    let realm = try? Realm()
    
    func save(task: Task) {
        guard let realm = realm else { return }
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error  {
            print(error)
        }
    }
    
    func fetchTasks() -> [Task]? {
        guard let realm = realm else { return nil}
        return Array(realm.objects(Task.self))
    }
}

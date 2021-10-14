//
//  AddModulePresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

// MARK: - ViewProtocol
protocol AddModuleViewProtocol: AnyObject {
    func error()
    func reloadSetction()
}

// MARK: - PresenterProtocol
protocol AddModuleViewPresenterProtocol: AnyObject {
    var validate: Bool { get }
    var name: String? { get set }
    var description: String? { get set }
    var startDate: Date { get set }
    var endDate: Date { get set }
    var isAllDay: Bool { get set }
    init(view: AddModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol)
    func changeDate(_ date: Date, type: CellsConfiguration?)
    func editName(_ str: String?)
    func editDescription(_ str: String?)
    func toggle()
    func save()
}

// MARK: - Presenter
class AddModulePresenter: AddModuleViewPresenterProtocol {
    weak var view: AddModuleViewProtocol?
    var router: RouterProtocol?
    var memory: MemoryManagerProtocol?

    var validate: Bool {
        return name != nil && (isAllDay || (startDate <= endDate))
    }

    var name: String?
    var description: String?
    var isAllDay: Bool
    var startDate: Date
    var endDate: Date

    required init(view: AddModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol) {
        self.view = view
        self.router = router
        self.memory = memory
        self.isAllDay = true
        self.startDate = Date.startOfDay()
        self.endDate = Date.endOfDay()
    }

    func changeDate(_ date: Date, type: CellsConfiguration?) {
        guard let type = type else { return }
        if type == .startDate {
            startDate = date
        } else {
            endDate = date
        }
    }

    func toggle() {
        isAllDay = !isAllDay
        view?.reloadSetction()
    }

    func save() {
        if validate {
            let task = Task()
            task.name = name!
            task.about = description
            task.startDate = startDate
            task.endDate = endDate
            memory?.save(task: task)
            router?.popToRoot()
        } else {
            self.view?.error()
        }
    }
    
    func editName(_ str: String?) {
        self.name = str
    }
    
    func editDescription(_ str: String?) {
        self.description = str
    }
}

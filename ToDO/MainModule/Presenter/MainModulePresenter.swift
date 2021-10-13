//
//  MainModulePresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

// MARK: - ViewProtocol
protocol MainModuleViewProtocol: AnyObject {
    func loading()
    func empty()
    func show()
}

// MARK: - PresenterProtocol
protocol MainModuleViewPresenterProtocol: AnyObject {
    var date: Date? { get set }
    var tasks: [Task]? { get set }
    init(view: MainModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol)
    func fetchTasks(for date: Date?)
    func tapOnAddButton()
    func changeDate(new: Date)
}

// MARK: - Presenter
class MainPresenter: MainModuleViewPresenterProtocol {
    weak var view: MainModuleViewProtocol?
    var router: RouterProtocol?
    var memory: MemoryManagerProtocol?
    var date: Date?
    var tasks: [Task]?

    required init(view: MainModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol) {
        self.date = Date()
        self.view = view
        self.router = router
        self.memory = memory
        fetchTasks(for: date)
    }

    func fetchTasks(for date: Date?) {
        guard let date = date else { return }
        // ..
        print(date)
        self.view?.loading()

        self.tasks = memory?.fetchTasks()
        guard let tasks = tasks else { return }
        
        if tasks.count > 0 {
            self.view?.show()
        } else {
            self.view?.empty()
        }
    }

    func tapOnAddButton() {
        // present new screen
        router?.presentAddScreen()
    }

    func changeDate(new: Date) {
        if date != new {
            self.date = new
            fetchTasks(for: date)
        }
    }
}

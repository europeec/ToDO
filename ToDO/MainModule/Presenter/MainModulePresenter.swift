//
//  MainModulePresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

// MARK: - ViewProtocol
protocol MainModuleViewProtocol: AnyObject {
    func empty()
    func show()
}

// MARK: - PresenterProtocol
protocol MainModuleViewPresenterProtocol: AnyObject {
    var date: Date? { get set }
    var tableData: TableModel? { get set }
    init(view: MainModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol)
    func fetchTasks(at date: Date?)
    func presentDetailForIndexPath(_ indexPath: IndexPath)
    func tapOnAddButton()
    func changeDate(new: Date)
}

// MARK: - Presenter
class MainPresenter: MainModuleViewPresenterProtocol {
    weak var view: MainModuleViewProtocol?
    var router: RouterProtocol?
    var memory: MemoryManagerProtocol?
    var date: Date?
    var tableData: TableModel?

    required init(view: MainModuleViewProtocol, router: RouterProtocol, memory: MemoryManagerProtocol) {
        self.date = Date()
        self.view = view
        self.router = router
        self.memory = memory
    }

    func fetchTasks(at date: Date?) {
        guard let date = date else { return }

        guard let tasks = memory?.fetchTasks(at: date) else { return }
        self.tableData = TableModel(tasks: tasks)

        if tasks.count > 0 {
            self.view?.show()
        } else {
            self.view?.empty()
        }
    }

    func presentDetailForIndexPath(_ indexPath: IndexPath) {
        guard let task = tableData?.sections[indexPath.section].tasks?[indexPath.row] else { return }
        router?.presentDetail(task: task)
    }

    func tapOnAddButton() {
        router?.presentAddScreen()
    }

    func changeDate(new: Date) {
        if date != new {
            self.date = new
            fetchTasks(at: date)
        }
    }
}

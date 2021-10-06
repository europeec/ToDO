//
//  MainModulePresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

protocol MainModuleViewProtocol: AnyObject {
    func loading()
    func empty()
    func show()
}

protocol MainModuleViewPresenterProtocol: AnyObject {
    var date: Date? { get set }
    var tasks: [Task]? { get set }
    init(view: MainModuleViewProtocol, router: RouterProtocol)
    func fetchTasks(for date: Date?)
    func tapOnAddButton()
    func changeDate(new: Date)
}

class MainPresenter: MainModuleViewPresenterProtocol {
    weak var view: MainModuleViewProtocol?
    var router: RouterProtocol?
    var date: Date?
    var tasks: [Task]?
    
    required init(view: MainModuleViewProtocol, router: RouterProtocol) {
        self.date = Date()
        self.view = view
        self.router = router
        fetchTasks(for: date)
    }
    
    func fetchTasks(for date: Date?) {
        guard let date = date else { return }
        // ..
        print(date)
        self.view?.loading()
    
        self.tasks = []
        
        if tasks != nil, tasks!.count > 0 {
            self.view?.show()
        } else {
            self.view?.empty()
        }
    }
    
    func tapOnAddButton() {
        // present new screen
    }
    
    func changeDate(new: Date) {
        if date != new {
            self.date = new
            fetchTasks(for: date)
        }
    }
}

//
//  AddModulePresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

protocol AddModuleViewProtocol: AnyObject {
    func error()
    func reloadSetction()
}

protocol AddModuleViewPresenterProtocol: AnyObject {
    var validate: Bool { get }
    var name: String? { get set }
    var description: String? { get set }
    var startDate: Date? { get set }
    var endDate: Date? { get set }
    var isAllDay: Bool { get set }
    init(view: AddModuleViewProtocol, router: RouterProtocol)
    func changeDate(_ date: Date, type: CellsConfiguration?)
    func toggle()
    func save()
}

class AddModulePresenter: AddModuleViewPresenterProtocol {
    weak var view: AddModuleViewProtocol?
    var router: RouterProtocol?
    
    var validate: Bool {
        return name != nil && (isAllDay || (endDate != nil && startDate != nil))
    }
    
    var name: String?
    var description: String?
    var isAllDay: Bool
    var startDate: Date?
    var endDate: Date?
    
    required init(view: AddModuleViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.isAllDay = true
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
        // TODO
        if validate {
            
        }
    }
}

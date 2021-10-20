//
//  DetailPresenter.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 20.10.2021.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func show()
}

protocol DetailPresenterViewProtocol: AnyObject {
    var task: Task { get set }
    init(view: DetailViewProtocol, task: Task)
}

class DetailPresenter: DetailPresenterViewProtocol {
    weak var view: DetailViewProtocol?
    var task: Task
    
    required init(view: DetailViewProtocol, task: Task) {
        self.view = view
        self.task = task
    }
}

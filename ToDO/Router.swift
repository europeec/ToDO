//
//  Router.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

protocol RouterMainProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    var memory: MemoryManagerProtocol? { get set }
    func initialMainViewController()
}

protocol RouterProtocol: RouterMainProtocol {
    func presentAddScreen()
    func presentDetail(task: Task)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    var memory: MemoryManagerProtocol?

    init(navigationController: UINavigationController?, builder: BuilderProtocol?, memory: MemoryManagerProtocol?) {
        self.navigationController = navigationController
        self.builder = builder
        self.memory = memory
    }

    func initialMainViewController() {
        if let navigationController = navigationController {
            guard let memory = memory, let mainViewController = builder?.createMainModule(router: self, memory: memory) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func presentAddScreen() {
        if let navigationController = navigationController {
            guard let memory = memory, let addViewController = builder?.createAddModule(router: self, memory: memory) else { return }
            navigationController.pushViewController(addViewController, animated: true)
        }
    }

    func presentDetail(task: Task) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailModule(with: task) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

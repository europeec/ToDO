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
    func initialMainViewController()
}

protocol RouterProtocol: RouterMainProtocol {
    func presentAddScreen()
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController?, builder: BuilderProtocol?) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialMainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func presentAddScreen() {
        if let navigationController = navigationController {
            guard let addViewController = builder?.createAddModule(router: self) else { return }
            navigationController.pushViewController(addViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

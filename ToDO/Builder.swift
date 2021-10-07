//
//  Builder.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createAddModule(router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createAddModule(router: RouterProtocol) -> UIViewController {
        let view = AddScreenViewController()
        let presenter = AddModulePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}

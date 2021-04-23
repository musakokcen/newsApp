//
//  CategoryRouter.swift
//  News
//
//  Created Musa Kokcen on 14.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CategoryRouterInterface {
    func navigateToNews(with category: Category)
}

final class CategoryRouter {
    weak var presenter: CategoryPresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = CategoryInteractor()
        let view = CategoryViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = CategoryRouter(navigationController: navCon)
        let presenter = CategoryPresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

extension CategoryRouter: CategoryRouterInterface {
    func navigateToNews(with category: Category) {
        let view = NewsRouter.createModule(with: category, navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
}

//
//  NewsRouter.swift
//  News
//
//  Created Musa Kokcen on 15.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsRouterInterface {
    func navigateToArticle(with source: URL)
}

final class NewsRouter {
    weak var presenter: NewsPresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(with category: Category, navigationController: UINavigationController?) -> UIViewController {

        let interactor = NewsInteractor()
        let view = NewsViewController.instantiate()
        let router = NewsRouter(navigationController: navigationController)
        let presenter = NewsPresenter(router: router, interactor: interactor, view: view, category: category)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension NewsRouter: NewsRouterInterface {
    func navigateToArticle(with source: URL) {
        let view = ArticleRouter.createModule(with: source, navigationController: navigationController)
        navigationController?.pushViewController(view, animated: true)
    }
}

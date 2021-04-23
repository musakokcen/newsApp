//
//  ArticleRouter.swift
//  News
//
//  Created Musa Kokcen on 16.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ArticleRouterInterface {

}

final class ArticleRouter {
    weak var presenter: ArticlePresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(with newsSource: URL, navigationController: UINavigationController?) -> UIViewController {

        let interactor = ArticleInteractor()
        let view = ArticleViewController.instantiate()
        let router = ArticleRouter(navigationController: navigationController)
        let presenter = ArticlePresenter(router: router, interactor: interactor, view: view, newsSource: newsSource)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

extension ArticleRouter: ArticleRouterInterface {
    
}

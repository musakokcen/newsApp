//
//  ArticlePresenter.swift
//  News
//
//  Created Musa Kokcen on 16.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ArticlePresenterInterface: PresenterInterface {
    func articleLoaded()
}

final class ArticlePresenter {

    private let newsSource: URL
    
	let router: ArticleRouterInterface
	let interactor: ArticleInteractorInterface
    weak var view: ArticleViewInterface?

    init(router: ArticleRouterInterface, interactor: ArticleInteractorInterface, view: ArticleViewInterface?, newsSource: URL) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.newsSource = newsSource
    }
}

extension ArticlePresenter: ArticlePresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.prepareArticle(with: newsSource)
        view?.showHUD(text: Localizable.loadingArticle, onMainThread: true)
    }
    
    func articleLoaded() {
        view?.dismissHUD()
    }
}

extension ArticlePresenter: ArticleInteractorOutput {
    
}

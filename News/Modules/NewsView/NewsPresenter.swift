//
//  NewsPresenter.swift
//  News
//
//  Created Musa Kokcen on 15.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension NewsPresenter {
    struct Constant {
        static let pageSize: Int = 10
        static let americanEnglishTime: String = "en_US_POSIX"
    }
}

protocol NewsPresenterInterface: PresenterInterface {
    func getNumberOfRows() -> Int
    func getData(for indexPath: IndexPath) -> NewsCellModel
    func searchBarTextChanged(to text: String)
    func articleSelected(at indexPath: IndexPath)
    func refreshNews()
    func willDisplayCell(at indexPath: IndexPath)
}

final class NewsPresenter {
    
    let router: NewsRouterInterface
    let interactor: NewsInteractorInterface
    weak var view: NewsViewInterface?
    
    private var category: Category
    private var page: Int = 1
    private var news: HeadlinesRequestResponse?
    private var isNewSearch: Bool = true
    private var lastSearch: String = ""
    
    init(router: NewsRouterInterface, interactor: NewsInteractorInterface, view: NewsViewInterface?, category: Category) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.category = category
    }
    
    private func loadMoreNews() {
        guard let news = news else {return}
        // if it is ten then it is not greater
        if news.totalResults > news.articles.count {
            isNewSearch = false
            view?.showHUD(text: Localizable.loadingMoreNews, onMainThread: true)
            page += 1
            interactor.fetchNews(for: category, pageSize: Constant.pageSize, page: page, search: nil)
        }
    }
}

extension NewsPresenter: NewsPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.setNavigationControllerTitle(with: category.rawValue.uppercased())
        view?.showHUD(text: Localizable.loadingNews, onMainThread: true)
        interactor.fetchNews(for: category, pageSize: Constant.pageSize, page: page, search: nil)
    }
    
    func getNumberOfRows() -> Int {
        news?.articles.count ?? 0
    }
    
    func getData(for indexPath: IndexPath) -> NewsCellModel {
        guard let newsForRow = news?.articles[indexPath.row] else {return NewsCellModel(imageUrl: nil, title: "", date: "")}
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constant.americanEnglishTime)
        dateFormatter.dateFormat = Date.Format.yyyy_MM_dd_T_HH_mm_ssZ
        let date = dateFormatter.date(from: newsForRow.publishedAt)
        
        let displayDate = date?.toString(withFormat: Date.Format.clockYearDisplay) ?? ""
        
        let data = NewsCellModel(imageUrl: newsForRow.urlToImage, title: newsForRow.title, date: displayDate)
        
        return data
    }
    
    func searchBarTextChanged(to text: String) {
        lastSearch = text
        isNewSearch = true

        page = 1
        view?.dismissHUD()
        view?.showHUD(text: String(format: Localizable.loadingSearchedNews, text), onMainThread: false)
        interactor.fetchNews(for: category, pageSize: Constant.pageSize, page: page, search: text)
    }
    
    func articleSelected(at indexPath: IndexPath) {
        if let urlString = news?.articles[indexPath.row].url, let url = URL(string: urlString) {
            router.navigateToArticle(with: url)
        }
    }
    
    func refreshNews() {
        isNewSearch = true
        interactor.fetchNews(for: category, pageSize: Constant.pageSize, page: page, search: lastSearch)
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        if indexPath.row == (news?.articles.count ?? 0) - 1 {
            loadMoreNews()
        }
    }
}

extension NewsPresenter: NewsInteractorOutput {
    func onFetchedNews(_ result: Result<HeadlinesRequestResponse, APIClientError>, search: String?) {
        view?.dismissHUD()
        switch result {
        case .success(let response):
            if isNewSearch {
                news = response
            } else {
                if news != nil {
                    news?.articles.append(contentsOf: response.articles)
                } else {
                    news = response
                }
            }

            view?.reloadTableView()
        case .failure(let error):
            if search == nil || lastSearch == search {
                view?.showAlert(message: error.message, title: Localizable.error, action: nil)
            }
        }
    }
}

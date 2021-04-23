//
//  NewsInteractor.swift
//  News
//
//  Created Musa Kokcen on 15.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol NewsInteractorInterface {
    func fetchNews(for category: Category, pageSize: Int, page: Int, search: String?)
}

protocol NewsInteractorOutput: class {
    func onFetchedNews(_ result: Result<HeadlinesRequestResponse, APIClientError>, search: String?)
}

final class NewsInteractor {
    weak var output: NewsInteractorOutput?
}

extension NewsInteractor: NewsInteractorInterface {
    func fetchNews(for category: Category, pageSize: Int, page: Int, search: String?) {
        NetworkManager.sharedInstance.cancelRequests { _ in
                NetworkManager.sharedInstance.request(endpoint: HeadlinesRequestEndpointItem.headlines(request: HeadlinesRequest(category: category.rawValue, pageSize: pageSize, page: page, q: search)), type: HeadlinesRequestResponse.self) { [weak self] (result) in
                    self?.output?.onFetchedNews(result, search: search)
                }
        }

    }
}

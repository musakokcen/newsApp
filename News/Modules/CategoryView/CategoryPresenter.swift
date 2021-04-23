//
//  CategoryPresenter.swift
//  News
//
//  Created Musa Kokcen on 14.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

enum Category: String, CaseIterable, Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

protocol CategoryPresenterInterface: PresenterInterface {
    func getNumberOfRows() -> Int
    func getCellForRow(at indexPath: IndexPath) -> Category
    func didSelectCategory(at indexPath: IndexPath)
}

final class CategoryPresenter {

	let router: CategoryRouterInterface
	let interactor: CategoryInteractorInterface
    weak var view: CategoryViewInterface?

    private var categories: [Category] = []
    
    init(router: CategoryRouterInterface, interactor: CategoryInteractorInterface, view: CategoryViewInterface?) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    private func prepareCollectionViewData() {
        Category.allCases.forEach { (category) in
            categories.append(category)
        }
    }
}

extension CategoryPresenter: CategoryPresenterInterface {
    func viewDidLoad() {
        prepareCollectionViewData()
        view?.prepareUI()
    }
    
    func getNumberOfRows() -> Int {
        return categories.count
    }
    
    func getCellForRow(at indexPath: IndexPath) -> Category {
        return categories[indexPath.row]
    }
    
    func didSelectCategory(at indexPath: IndexPath) {
        router.navigateToNews(with: categories[indexPath.row])
    }
}

extension CategoryPresenter: CategoryInteractorOutput {
    
}

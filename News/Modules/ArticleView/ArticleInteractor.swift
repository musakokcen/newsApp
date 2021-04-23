//
//  ArticleInteractor.swift
//  News
//
//  Created Musa Kokcen on 16.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ArticleInteractorInterface {
    
}

protocol ArticleInteractorOutput: class {

}

final class ArticleInteractor {
    weak var output: ArticleInteractorOutput?
}

extension ArticleInteractor: ArticleInteractorInterface {
}

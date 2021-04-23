//
//  CategoryInteractor.swift
//  News
//
//  Created Musa Kokcen on 14.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CategoryInteractorInterface {

}

protocol CategoryInteractorOutput: class {

}

final class CategoryInteractor {
    weak var output: CategoryInteractorOutput?
}

extension CategoryInteractor: CategoryInteractorInterface {
    
}

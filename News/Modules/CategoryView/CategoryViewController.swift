//
//  CategoryViewController.swift
//  News
//
//  Created Musa Kokcen on 14.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

private extension CategoryViewController {
    struct Constant {
        struct UI {
            static let title: String = Localizable.categories.uppercased()
            static let backgroundColor: UIColor = .white
            static let textColor: UIColor = .black
            
            struct Category {
                static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
                static let numberOfCellsForRow: CGFloat = 3
                static let minimumLineSpacing: CGFloat = 8
                static let minimumInteritemSpacing: CGFloat = 0
            }
        }
    }
}

protocol CategoryViewInterface: ViewInterface {
	func prepareUI()
}

final class CategoryViewController: BaseViewController, Storyboarded {

    @IBOutlet private weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.register(CategoryCell.getNib(), forCellWithReuseIdentifier: CategoryCell.identifier)
        }
    }
    
    static var storyboardName: String {
        return StoryboardNames.main.rawValue
    }
    
    var presenter: CategoryPresenterInterface!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private func prepareNavigationBar() {
        navigationItem.title = Constant.UI.title
        navigationController?.navigationBar.changeTransparency(to: .transparent)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.UI.textColor]
    }
    
    private func prepareCategoryCollectionView() {
        categoryCollectionView.backgroundColor = Constant.UI.backgroundColor
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.alwaysBounceVertical = true
        
        if let flowLayout = categoryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = .zero
            flowLayout.sectionInset = Constant.UI.Category.sectionInset
        }
    }
}

extension CategoryViewController: CategoryViewInterface {
	func prepareUI() {
        view.backgroundColor = Constant.UI.backgroundColor
        prepareNavigationBar()
        prepareCategoryCollectionView()
	}
}

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCategory(at: indexPath)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: CategoryCell.self, for: indexPath)
        cell.configure(with: presenter.getCellForRow(at: indexPath))
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let width = collectionView.frame.size.width / Constant.UI.Category.numberOfCellsForRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constant.UI.Category.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constant.UI.Category.minimumInteritemSpacing
    }
}

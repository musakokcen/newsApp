//
//  CategoryCollectionViewCell.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import UIKit

extension CategoryCell {
    struct Constant {
        struct UI {
            static let backgroundColor: UIColor = .white
            static let textColor: UIColor = .black
        }
    }
}
class CategoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    func configure(with data: Category) {
        
        backgroundColor = Constant.UI.backgroundColor
        
        categoryLabel.text = data.rawValue.uppercased()
        categoryLabel.textColor = Constant.UI.textColor
        
        categoryImageView.image = data.image ?? categoryImageView.image
        categoryImageView.contentMode = .scaleAspectFit
    }
    
}

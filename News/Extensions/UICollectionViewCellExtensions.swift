//
//  UICollectionViewCellExtension.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}

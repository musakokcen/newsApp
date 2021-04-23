//
//  UITableViewExtensions.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}

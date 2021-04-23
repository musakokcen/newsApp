//
//  UITableViewExtensions.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import UIKit

extension UITableViewCell {
    class func getNib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
    
    class var identifier: String {
        return self.className
    }
}

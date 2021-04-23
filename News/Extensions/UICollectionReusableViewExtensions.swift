//
//  UICollectionReusableView.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import UIKit

extension UICollectionReusableView {
    class func getNib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    class var identifier: String {
        return self.className
    }
}

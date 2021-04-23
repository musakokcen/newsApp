//
//  NSObjectExtension.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation
extension NSObject {
    public var className: String {
        return type(of: self).className
    }

    public static var className: String {
        return String(describing: self)
    }
}

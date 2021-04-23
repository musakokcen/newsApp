//
//  Storyboarded.swift
//  MathSolver
//
//  Created by Mehmet Kerem Keskin on 16.12.2020.
//  Copyright © 2020 MathSolver. All rights reserved.
//

import Foundation

import UIKit

public protocol Storyboarded {
    static var storyboardName: String { get }

    static func instantiate() -> Self

    static func instantiate(identifier: String) -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        return instantiate(identifier: self.className)
    }

    static func instantiate(identifier: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Storyboard cannot be instantiated")
        }

        return vc
    }
}

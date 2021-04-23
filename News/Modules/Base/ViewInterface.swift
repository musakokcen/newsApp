//
//  ViewInterface.swift
//  MathSolver
//
//  Created by Mehmet Kerem Keskin on 16.12.2020.
//  Copyright © 2020 MathSolver. All rights reserved.
//

import UIKit

public protocol ViewInterface: class {
    static var storyboardId: String { get }

    func setTitle(_ title: String)
    func showHUD(text: String, onMainThread: Bool)
    func dismissHUD()
    func showAlert(message: String, title: String, action: (() -> Void)?)
}

public extension ViewInterface where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }

    func setTitle(_ title: String) {
        self.title = title
    }
    
    func showHUD(text: String, onMainThread: Bool = false) {
        self.showHUD(text: text, onMainThread: onMainThread)
    }
    
    func dismissHUD() {
        self.dismissHUD()
    }
    
    func showAlert(message: String, title: String, action: (() -> Void)?) {
        Utils.showAlert(message: message, title: title, view: self, action: action)
    }
}

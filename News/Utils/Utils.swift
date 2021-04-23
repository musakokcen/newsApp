//
//  Utils.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import UIKit

class Utils {
    class func showAlert(message: String, title: String, view: UIViewController, action: (() -> Void)?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.addAction(UIAlertAction(title: Localizable.ok, style: .default, handler: { _ in
            if let action = action {
                action()
            }
        }))
        view.present(alertViewController, animated: true)
    }
}

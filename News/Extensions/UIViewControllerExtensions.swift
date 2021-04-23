//
//  UIViewControllerExtensions.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import MBProgressHUD

extension UIViewController {
    
    func showHUD(text: String, onMainThread: Bool = false) {
        func addHUD() {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.mode = .indeterminate
            progressHUD.label.text = text
            progressHUD.label.font = UIFont.systemFont(ofSize: 14)
            progressHUD.label.textColor = .black
            progressHUD.contentColor = .black
            progressHUD.bezelView.color = UIColor.lightGray.withAlphaComponent(0.4)
            progressHUD.bezelView.style = .solidColor
        }
        
        if onMainThread {
            addHUD()
        } else {
            DispatchQueue.main.async {
                addHUD()
            }
        }
    }

    func dismissHUD(isAnimated: Bool = true) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}

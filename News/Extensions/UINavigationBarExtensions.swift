//
//  UINavigationBarExtensions.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import UIKit

extension UINavigationBar {
    
    enum Transparency {
        case transparent
        case opaque(backgroundColor: UIColor)
    }
    
    func changeTransparency(to transparency: Transparency) {
        switch transparency {
        case .transparent:
            changeProperties(isTranslucent: true, backgroundImage: UIImage(), shadowColor: .clear, backgroundColor: .clear, barTintColor: .clear)
        case .opaque(let backgroundColor):
            changeProperties(isTranslucent: false, backgroundImage: backgroundColor.as1ptImage(), shadowColor: UIColor.black, backgroundColor: backgroundColor, barTintColor: backgroundColor)
        }
    }
    
    func changeProperties(isTranslucent: Bool, backgroundImage: UIImage?, shadowColor: UIColor, backgroundColor: UIColor, barTintColor: UIColor) {
        self.barTintColor = barTintColor
        self.isTranslucent = isTranslucent
        self.shadowImage = shadowColor.as1ptImage()
        setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
        self.backgroundColor = backgroundColor
        removeShadow()
        showBottomHairline()
    }
    
    func removeShadow() {
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0.0
    }
    
    func showBottomHairline() {
        hairlineImageViewInNavigationBar(self)?.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1 {
            return imageView
        }
        
        for subview: UIView in view.subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        return nil
    }
}

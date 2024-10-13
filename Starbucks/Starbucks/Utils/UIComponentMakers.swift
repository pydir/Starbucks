//
//  UIComponentMakers.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import UIKit

class UIComponentMakers {
    static func makeSymbolImageView(systemName: String, scale: UIImage.SymbolScale = .large) -> UIImageView {
        let configuration   = UIImage.SymbolConfiguration(scale: scale)
        let image           = UIImage(systemName: systemName, withConfiguration: configuration)
        
        return UIImageView(image: image)
    }
}

public extension NSLayoutConstraint {
    @objc func setActiveBreakable(prioty: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = prioty
        isActive = true
    }
}

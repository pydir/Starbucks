//
//  UIFont+Extensions.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import Foundation
import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size:0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}

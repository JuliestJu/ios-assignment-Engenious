//
//  CALayer+Extension.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 10.01.2024.
//

import UIKit

extension CALayer {
    func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor) {
        shadowOffset = offset
        shadowOpacity = opacity
        shadowRadius = radius
        shadowColor = color.cgColor
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
    
    func removeDropShadow() {
        shadowOffset = .zero
        shadowOpacity = 0
        shadowRadius = 0
        shadowColor = UIColor.clear.cgColor
        shouldRasterize = false
    }
}

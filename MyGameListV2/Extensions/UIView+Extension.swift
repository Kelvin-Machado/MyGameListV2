//
//  UIView+Extension.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 25/01/24.
//

import UIKit

extension UIView {
    func applyGradientBackground(colors: [UIColor]) {
        let startPoint: CGPoint = CGPoint(x: 0, y: 0)
        let endPoint: CGPoint = CGPoint(x: 1, y: 1)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        let gradientColors = colors.map { $0.cgColor }
        
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


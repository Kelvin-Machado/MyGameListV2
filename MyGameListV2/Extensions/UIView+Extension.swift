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

extension UIView {
    private static let shimmerAnimationKey = "shimmer"
    
    var isShimmering: Bool {
        get { layer.mask?.animation(forKey: Self.shimmerAnimationKey) != nil }
        set { newValue ? startShimmering() : stopShimmering() }
    }
    
    private func startShimmering() {
        let white = UIColor.white.cgColor
        let alphaWhite = UIColor.white.withAlphaComponent(0.75).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alphaWhite, white, alphaWhite]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width * 3, height: bounds.height)
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.25
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: Self.shimmerAnimationKey)
    }
    
    private func stopShimmering() {
        layer.mask = nil
    }
}

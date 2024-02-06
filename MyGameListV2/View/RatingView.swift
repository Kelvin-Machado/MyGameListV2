//
//  RatingView.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/02/24.
//

import UIKit

class RatingView: UIView {
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private var starViews: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(starsStackView)
        
        NSLayoutConstraint.activate([
            starsStackView.topAnchor.constraint(equalTo: topAnchor),
            starsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = UIColor.orange
            starImageView.contentMode = .scaleAspectFit
            starViews.append(starImageView)
            starsStackView.addArrangedSubview(starImageView)
        }
    }
    
    func setRating(rating: Double, maxRating: Double) {
        let normalizedRating = min(max(rating, 0), maxRating)
        let filledStars = Int((normalizedRating / maxRating) * 5)
        
        for (index, starView) in starViews.enumerated() {
            if index < filledStars {
                starView.isHidden = false
            } else {
                starView.isHidden = true
            }
        }
    }
}


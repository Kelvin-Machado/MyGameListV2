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
        stackView.spacing = 2
        return stackView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Color.black
        return label
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
        addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            starsStackView.topAnchor.constraint(equalTo: topAnchor),
            starsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starsStackView.trailingAnchor, constant: 6),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = Color.goldenYellow
            starImageView.contentMode = .scaleAspectFit
            starViews.append(starImageView)
            starsStackView.addArrangedSubview(starImageView)
        }
    }
    
    func setRating(rating: Double, maxRating: Double) {
        let normalizedRating = min(max(rating, 0), maxRating)
        let filledStars = Int(round((normalizedRating / maxRating) * 5))
        
        for (index, starView) in starViews.enumerated() {
            if index < filledStars {
                if index == filledStars - 1 && (normalizedRating.truncatingRemainder(dividingBy: 1) > 0.3 && normalizedRating.truncatingRemainder(dividingBy: 1) < 0.7) {
                    starView.image = UIImage(systemName: "star.leadinghalf.fill")
                } else {
                    starView.image = UIImage(systemName: "star.fill")
                }
            } else {
                starView.image = UIImage(systemName: "star")
            }
        }
        
        ratingLabel.text = String(format: "%.2f", rating)
    }
}

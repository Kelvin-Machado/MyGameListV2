//
//  CarouselCollectionViewCell.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 23/02/24.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var shimmerView: UIView = {
        let shimmerView = UIView()
        shimmerView.backgroundColor = .gray
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.layer.cornerRadius = 10
        shimmerView.isHidden = false
        return shimmerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(shimmerView)
        
        shimmerView
            .top(to: topAnchor, constant: 16)
            .leading(to: leadingAnchor, constant: 16)
            .trailing(to: trailingAnchor, constant: -16)
            .bottom(to: bottomAnchor, constant: -16)
        
        imageView
            .top(to: shimmerView.topAnchor)
            .leading(to: shimmerView.leadingAnchor)
            .trailing(to: shimmerView.trailingAnchor)
            .bottom(to: shimmerView.bottomAnchor)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        shimmerView.isHidden = false
        shimmerView.isShimmering = true
    }
    
    func configure(with imageUrl: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shimmerView.isHidden = false
            self.shimmerView.isShimmering = true
            
            self.imageView.setImage(from: imageUrl) { _ in
                self.shimmerView.isHidden = true
                self.shimmerView.isShimmering = false
            }
        }
    }

}

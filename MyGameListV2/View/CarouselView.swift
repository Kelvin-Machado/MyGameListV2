//
//  CarouselView.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 16/02/24.
//

import UIKit

class CarouselView: UIView {
    
    private var imageInfos: [(index: Int, imageUrl: String)] = []
    private var currentIndex = 0
    private var timer: Timer?
    
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
        shimmerView.backgroundColor = Color.primary
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.layer.cornerRadius = 10
        return shimmerView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    private func setupViews() {
        addSubview(shimmerView)
        addSubview(imageView)
        addSubview(pageControl)
        
        shimmerView
            .top(to: imageView.topAnchor)
            .leading(to: imageView.leadingAnchor)
            .trailing(to: imageView.trailingAnchor)
            .bottom(to: imageView.bottomAnchor)
        
        imageView
            .top(to: topAnchor, constant: 16)
            .leading(to: leadingAnchor, constant: 16)
            .trailing(to: trailingAnchor, constant: -16)
            .height(equalTo: imageView.widthAnchor, multiplier: 475.0/844.0)
        
        pageControl
            .top(to: imageView.bottomAnchor, constant: 8)
            .leading(to: leadingAnchor)
            .trailing(to: trailingAnchor)
            .bottom(to: bottomAnchor)
    }
    
    func configure(with imageUrls: [String]) {
        loadImages(from: imageUrls)
    }
    
    private func loadImages(from imageUrls: [String]) {
        imageInfos.removeAll()
        for (index, imageUrl) in imageUrls.enumerated() {
            loadImage(from: imageUrl, atIndex: index)
        }
        
        updateUI()
    }
    
    private func loadImage(from urlString: String, atIndex index: Int) {
        guard let url = URL(string: urlString) else {
            // TODO: Adicionar tratamento de erro
            return
        }
        imageInfos.append((index: index, imageUrl: urlString))
        imageInfos.sort { $0.index < $1.index }
        if imageInfos.count == 1 {
            shimmerView.isHidden = false
            shimmerView.isShimmering = true
            imageView.setImage(from: urlString) {_ in
                self.shimmerView.isHidden = true
                self.shimmerView.isShimmering = false
            }
        }
        if currentIndex == 0 && imageInfos.count > 0 {
            shimmerView.isHidden = false
            shimmerView.isShimmering = true
            imageView.setImage(from: imageInfos[0].imageUrl) {_ in
                self.shimmerView.isHidden = true
                self.shimmerView.isShimmering = false
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { [weak self] _ in
            self?.advanceImage()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.pageControl.numberOfPages = self.imageInfos.count
            self.pageControl.isHidden = self.imageInfos.count <= 1
            self.pageControl.currentPage = self.currentIndex
        }
    }
    
    @objc private func advanceImage() {
        currentIndex = (currentIndex + 1) % imageInfos.count
        shimmerView.isHidden = false
        shimmerView.isShimmering = true
        imageView.setImage(from: imageInfos[currentIndex].imageUrl) {_ in
            self.shimmerView.isHidden = true
            self.shimmerView.isShimmering = false
        }
        pageControl.currentPage = currentIndex
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if touchLocation.x < bounds.width / 2 {
            currentIndex = (currentIndex - 1 + imageInfos.count) % imageInfos.count
        } else {
            currentIndex = (currentIndex + 1) % imageInfos.count
        }
        
        shimmerView.isHidden = false
        shimmerView.isShimmering = true
        imageView.setImage(from: imageInfos[currentIndex].imageUrl) {_ in
            self.shimmerView.isHidden = true
            self.shimmerView.isShimmering = false
        }
        pageControl.currentPage = currentIndex
    }
}

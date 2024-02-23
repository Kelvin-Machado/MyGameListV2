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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCell")
        return collectionView
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
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView
            .top(to: topAnchor)
            .leading(to: leadingAnchor)
            .trailing(to: trailingAnchor)
            .bottom(to: bottomAnchor)
        
        pageControl
            .bottom(to: collectionView.bottomAnchor, constant: 8)
            .centerX(to: centerXAnchor)
        
        updateUI()
    }
    
    func configure(with imageUrls: [String]) {
        loadImages(from: imageUrls)
    }
    
    private func loadImages(from imageUrls: [String]) {
        imageInfos = imageUrls.enumerated().map { (index, imageUrl) in
            return (index: index, imageUrl: imageUrl)
        }
        collectionView.reloadData()
        updateUI()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(advanceImage), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.pageControl.numberOfPages = self.imageInfos.count
            self.pageControl.isHidden = self.imageInfos.count <= 1
        }
    }
    
    @objc private func advanceImage() {
        currentIndex = (currentIndex + 1) % imageInfos.count
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
}

extension CarouselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCollectionViewCell
        cell.configure(with: imageInfos[indexPath.item].imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            currentIndex = visibleIndexPath.item
            pageControl.currentPage = currentIndex
        }
    }
}

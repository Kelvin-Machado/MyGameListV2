//
//  CarouselView.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 16/02/24.
//

import UIKit

class CarouselView: UIView {
    
    private var imageInfos: [(index: Int, image: UIImage)] = []
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
        addSubview(imageView)
        addSubview(pageControl)
        
        imageView
            .top(to: topAnchor, constant: 16)
            .leading(to: leadingAnchor, constant: 16)
            .trailing(to: trailingAnchor, constant: -16)
        
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
    }
    
    private func loadImage(from urlString: String, atIndex index: Int) {
        guard let url = URL(string: urlString) else {
            // TODO: Adicionar tratamento de erro
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Erro ao baixar a imagem: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageInfos.append((index: index, image: image))
                    self.imageInfos.sort { $0.index < $1.index }
                    self.pageControl.numberOfPages = self.imageInfos.count
                    if self.imageInfos.count == 1 {
                        self.imageView.image = image
                    }
                    if self.currentIndex == 0 && self.imageInfos.count > 0 {
                        self.imageView.image = self.imageInfos[0].image
                    }
                    self.pageControl.isHidden = self.imageInfos.count <= 1
                }
            }
        }.resume()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(advanceImage), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func advanceImage() {
        currentIndex = (currentIndex + 1) % imageInfos.count
        imageView.image = imageInfos[currentIndex].image
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
        
        imageView.image = imageInfos[currentIndex].image
        pageControl.currentPage = currentIndex
    }
}

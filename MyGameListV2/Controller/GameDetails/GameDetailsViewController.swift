//
//  GameDetailsViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/02/24.
//

import UIKit

class GameDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    let game: Game
    let screenshots: [String]
    
    private let carouselView: CarouselView = {
        let carouselView = CarouselView()
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        return carouselView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = .zero
        return label
    }()
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()
    
    private let platformsDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Novo", for: .normal)
        
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(game: Game, screenshots: [String]) {
        self.game = game
        self.screenshots = screenshots
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCarouselView()
        configureLabels()
        configureRatingView()
        configureDropDown()
        configureButtons()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = Color.background
        
        view.addSubview(carouselView)
        view.addSubview(nameLabel)
        view.addSubview(ratingView)
        view.addSubview(platformsDropDown)
        view.addSubview(newButton)
        view.addSubview(addButton)
        
        carouselView
            .top(to: view.safeAreaLayoutGuide.topAnchor)
            .leading(to: view.leadingAnchor)
            .trailing(to: view.trailingAnchor)
            .height(equalTo: carouselView.widthAnchor, multiplier: 475.0/844.0)
        
        nameLabel
            .top(to: carouselView.bottomAnchor, constant: 16)
            .leading(to: view.leadingAnchor, constant: 16)
            .trailing(to: view.trailingAnchor, constant: -16)
        
        ratingView
            .top(to: nameLabel.bottomAnchor, constant: 16)
            .trailing(to:view.trailingAnchor, constant: -16)
        
        platformsDropDown
            .top(to: ratingView.bottomAnchor, constant: 16)
            .leading(to: view.leadingAnchor, constant: 16)
        
        newButton
            .top(to: platformsDropDown.bottomAnchor, constant: 16)
            .leading(to: view.leadingAnchor, constant: 16)
        
        addButton
            .trailing(to: view.trailingAnchor, constant: -16)
            .bottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    }
    
    private func configureCarouselView() {
        
        var carouselImages: [String] = []
        if let imageUrl = game.backgroundImage {
            carouselImages.append(imageUrl)
        }
        if !screenshots.isEmpty {
            carouselImages = screenshots
        }
        carouselView.configure(with: carouselImages)
    //TODO: - Adicionar carregamento de outras imagens além do background principal
    }
    
    private func configureLabels() {
        nameLabel.text = game.name
    }
    
    private func configureRatingView() {
        guard let rating = game.rating, !rating.isZero else {
            ratingView.isHidden = true
            return
        }
        
        ratingView.isHidden = false
        ratingView.setRating(rating: rating, maxRating: 5.0)
    }
    
    private func configureDropDown() {
    }
    
    private func configureButtons() {
        newButton.addTarget(self, action: #selector(newButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func newButtonTapped() {
        //TODO: adicionar ação para o clique no botão de jogo novo
    }
    
    @objc private func addButtonTapped() {
        //TODO: adicionar ação para o clique no botão de adicionar jogo na lista
    }
}

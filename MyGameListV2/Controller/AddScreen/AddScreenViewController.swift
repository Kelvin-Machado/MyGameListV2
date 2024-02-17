//
//  AddScreenViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/02/24.
//

import UIKit

class AddScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    let game: Game
    
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
    
    init(game: Game) {
        self.game = game
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
        if let imageUrl = game.backgroundImage {
            carouselView.configure(with: [imageUrl])
        }
    //TODO: - Adicionar carregamento de outras imagens além do background principal
    }
    
    private func configureLabels() {
        nameLabel.text = game.name
    }
    
    private func configureRatingView() {
        ratingView.setRating(rating: game.rating ?? 0.0, maxRating: 5.0)
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

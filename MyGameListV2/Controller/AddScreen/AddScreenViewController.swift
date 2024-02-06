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
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //TODO: adicionar imagem placeholder
        return imageView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.whiteSmoke
        return view
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
        // Configure rating view properties as needed
        return ratingView
    }()
    
    private let platformsDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        // Configure dropdown properties as needed
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
        loadImage(from: game.backgroundImage ?? "")
        configureLabels()
        configureRatingView()
        configureDropDown()
        configureButtons()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = Color.background
        
        view.addSubview(gameImageView)
        view.addSubview(dividerView)
        view.addSubview(nameLabel)
        view.addSubview(ratingView)
        view.addSubview(platformsDropDown)
        view.addSubview(newButton)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor, multiplier: 475.0/844.0),
            
            dividerView.topAnchor.constraint(equalTo: gameImageView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            nameLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            ratingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            platformsDropDown.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16),
            platformsDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            platformsDropDown.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            newButton.topAnchor.constraint(equalTo: platformsDropDown.bottomAnchor, constant: 16),
            newButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            // TODO: Handle invalid URL
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.gameImageView.image = image
                }
            }
        }.resume()
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


//
//  SearchScreenViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 03/01/24.
//

import UIKit

class SearchScreenViewController: BaseViewController {

    
    //MARK: - properties
    let searchBar = UISearchController()
    var searchingGame = ""
    var searchedGame: Game? = nil
    
    let viewModel: SearchScreenViewModel

    
    //MARK: - views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - setup
    init(viewModel: SearchScreenViewModel = SearchScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.dimGray
        configuraSearchBar()
        configureTableView()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.searchResults
            .subscribe(onNext: { [weak self] game in
                print("Game Name: \(game.name)")
                print("Slug: \(game.slug)")
                if let redirect = game.redirect, redirect {
                    self?.searchingGame = game.slug
                    self?.viewModel.searchGames(withName: game.slug)
                }
                self?.searchedGame = game
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        searchBar.searchBar.rx.textDidEndEditing
            .subscribe(onNext: { [weak self] _ in
                self?.searchGames()
            })
            .disposed(by: disposeBag)
        
        searchBar.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchingGame = ""
            })
            .disposed(by: disposeBag)
    }
    
    
    func configuraSearchBar() {
        searchBar.searchBar.delegate = self
        searchBar.searchBar.autocapitalizationType = .none
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.placeholder = "Informe o nome do jogo"
        navigationItem.searchController = searchBar
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        view.addSubview(tableView)

        // Constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    private func searchGames() {
        guard !searchingGame.isEmpty else { return }
        
        searchingGame = searchingGame.lowercased().replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        viewModel.searchGames(withName: searchingGame)
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchingGame = ""
            return
        }
        
        searchingGame = searchText
    }
}

extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameCell else {
            return UITableViewCell()
        }

        if searchedGame != nil {
            let game = searchedGame
            cell.configure(with: game!)
        }

        return cell
    }
}

class GameCell: UITableViewCell {

    // Add UI elements for the custom cell, e.g., rectangular image and game name label
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Add additional configuration for the image view
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Add additional configuration for the label
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Add and configure UI elements, set up constraints
        addSubview(gameImageView)
        addSubview(nameLabel)

        // Constraints for the image view and label
        NSLayoutConstraint.activate([
            // Constraints for gameImageView
            gameImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gameImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            // Aspect ratio constraint to maintain the original aspect ratio (844:475)
            gameImageView.widthAnchor.constraint(equalTo: gameImageView.heightAnchor, multiplier: 844.0 / 475.0),

            // Constraints for nameLabel
            nameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }


    func configure(with game: Game) {
        // Configure the cell with data from the game model
        nameLabel.text = game.name
        loadImage(from: game.backgroundImage ?? "")
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            // Lógica de tratamento para URLs inválidas
            return
        }

        // Use URLSession para baixar a imagem da URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Lógica de tratamento para erros de download
                print("Erro ao baixar a imagem: \(error.localizedDescription)")
                return
            }

            if let data = data, let image = UIImage(data: data) {
                // Atualiza a interface do usuário na thread principal
                DispatchQueue.main.async {
                    self.gameImageView.image = image
                }
            }
        }.resume()
    }
}

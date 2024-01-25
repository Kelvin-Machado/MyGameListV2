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
        tableView.backgroundColor = Color.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
        view.applyGradientBackground(colors: [Color.uiColor(Color.backgroundGradient1), Color.uiColor(Color.backgroundGradient2), Color.uiColor(Color.backgroundGradient1)])
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
        searchBar.searchBar.barStyle = .black
        navigationItem.searchController = searchBar
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchResultCollectionViewCell.self, forCellReuseIdentifier: "GameCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
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
        return searchedGame != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? SearchResultCollectionViewCell, searchedGame != nil else {
            return UITableViewCell()
        }
        cell.configure(with: searchedGame!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchedGame = searchedGame else { return }
        print(searchedGame.name)
    }
}

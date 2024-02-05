//
//  AddSearchScreenViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 04/02/24.
//

import UIKit

class AddSearchScreenViewController: BaseViewController {
    
    //MARK: - properties
    let searchBar = UISearchController()
    var searchingGame = ""
    var searchedGame: Game? = nil
    var isLoad: Bool = false
    
    let viewModel: AddSearchScreenViewModel

    
    //MARK: - views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - setup
    init(viewModel: AddSearchScreenViewModel = AddSearchScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradientBackground(colors: Color.backgroundGradient)
        configuraSearchBar()
        configureTableView()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.searchResults
            .subscribe(onNext: { [weak self] result in
                self?.isLoad = true
                switch result {
                case .success(let game):
                    print("Game Name: \(game.name)")
                    print("Slug: \(game.slug)")
                    if let redirect = game.redirect, redirect {
                        self?.searchingGame = game.slug
                        self?.viewModel.searchGames(withName: game.slug)
                        return
                    }
                    self?.searchedGame = game
                    self?.tableView.reloadData()
                case .failure(let error):
                    let errorPopup = ErrorPopupViewController(errorMessage: error.localizedDescription)
                    self?.present(errorPopup, animated: true, completion: nil)
                }
                
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
        tableView.register(SearchResultViewCell.self, forCellReuseIdentifier: "GameCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    private func searchGames() {
        guard !searchingGame.isEmpty else { return }
        
        isLoad = false
        searchedGame = nil
        tableView.reloadData()
        
        searchingGame = searchingGame.lowercased().replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        viewModel.searchGames(withName: searchingGame)
    }
}

extension AddSearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchingGame = ""
            return
        }
        
        searchingGame = searchText
    }
}

extension AddSearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoad ? 1 : (!isLoad && searchingGame.isEmpty ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? SearchResultViewCell else {
            return UITableViewCell()
        }
        if isLoad, searchedGame != nil {
            cell.configure(with: searchedGame, isLoad: isLoad)
        } else {
            cell.configure(with: nil, isLoad: isLoad)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let resultCell = cell as? SearchResultViewCell {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resultCell.containerView.isShimmering = !self.isLoad
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchedGame = searchedGame else { return }
        print(searchedGame.name)
    }
}

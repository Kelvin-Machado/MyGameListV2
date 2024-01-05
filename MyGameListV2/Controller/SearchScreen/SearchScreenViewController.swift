//
//  SearchScreenViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 03/01/24.
//

import UIKit

class SearchScreenViewController: BaseViewController {

    let searchBar = UISearchController()
    var searchingGame = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.dimGray
        configuraSearchBar()
    }
    
    func configuraSearchBar() {
        searchBar.searchBar.delegate = self
        searchBar.searchBar.autocapitalizationType = .none
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.placeholder = "informe o nome do jogo"
        navigationItem.searchController = searchBar
    }

}

extension SearchScreenViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchingGame = ""
            return
        }
        
        searchingGame = searchText
        print(searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard !searchingGame.isEmpty else { return }
        
        print(searchingGame)
        searchingGame = searchingGame.lowercased().replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        print("End editing: \(searchingGame)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchingGame = ""
    }
}

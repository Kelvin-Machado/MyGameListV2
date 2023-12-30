//
//  TabViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 30/12/23.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray

    }
    
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let search = createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: HomeViewController())
        let add = createNav(with: "Add a Game", and: UIImage(systemName: "plus.circle"), vc: HomeViewController())
        let list = createNav(with: "MyGameList", and: UIImage(systemName: "list.star"), vc: HomeViewController())
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person"), vc: HomeViewController())
        
        
        self.setViewControllers([home, search, add, list, profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
//        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        
        return nav
    }
    

}

//
//  TabViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 30/12/23.
//

import UIKit

class TabViewController: CustomTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.backgroundColor = Color.primary
        tabBar.unselectedItemTintColor = .lightGray

    }
    
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let home = createNav(with: "home", and: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), vc: HomeViewController())
        let search = createNav(with: "search", and: UIImage(systemName: "magnifyingglass"), selectedImage: nil, vc: SearchScreenViewController(viewModel: SearchScreenViewModel(dataProvider: SearchScreenDataProvider())))
        let add = createNav(with: "add a game", and: UIImage(systemName: "plus.circle"), selectedImage: UIImage(systemName: "plus.circle.fill"), vc: AddSearchScreenViewController())
        let list = createNav(with: "MyGameList", and: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"), vc: HomeViewController())
        let profile = createNav(with: "profile", and: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), vc: HomeViewController())

        self.setViewControllers([home, search, add, list, profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
//        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        if selectedImage != nil {
            nav.tabBarItem.selectedImage = selectedImage
        }
        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
    

}

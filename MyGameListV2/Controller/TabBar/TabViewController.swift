//
//  TabViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 30/12/23.
//

import UIKit

private enum Constants {
    static let home = UIImage(systemName: "house")
    static let houseFill = UIImage(systemName: "house.fill")
    static let magnifyingglass = UIImage(systemName: "magnifyingglass")
    static let plusCircle = UIImage(systemName: "plus.circle")?.withTintColor(Color.lime ?? .green, renderingMode: .alwaysOriginal)
    static let plusCircleFill = UIImage(systemName: "plus.circle.fill")?.withTintColor(Color.lime ?? .green, renderingMode: .alwaysOriginal)
    static let listBulletRectangle = UIImage(systemName: "list.bullet.rectangle")
    static let listBulletRectangleFill = UIImage(systemName: "list.bullet.rectangle.fill")
    static let person = UIImage(systemName: "person")
    static let personFill = UIImage(systemName: "person.fill")
}

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
        let home = createNav(with: "home", and: Constants.home, selectedImage: Constants.houseFill, vc: HomeViewController())
        let search = createNav(with: "search", and: Constants.magnifyingglass, selectedImage: nil, vc: SearchScreenViewController(viewModel: SearchScreenViewModel(dataProvider: SearchScreenDataProvider())))
        let add = createNav(with: "add a game", and: Constants.plusCircle, selectedImage: Constants.plusCircleFill, vc: AddSearchScreenViewController())
        let list = createNav(with: "MyGameList", and: Constants.listBulletRectangle, selectedImage: Constants.listBulletRectangleFill, vc: HomeViewController())
        let profile = createNav(with: "profile", and: Constants.person, selectedImage: Constants.personFill, vc: HomeViewController())

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

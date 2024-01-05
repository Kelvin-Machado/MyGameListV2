//
//  BaseViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 02/01/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    func setupBaseUI() {
        initNavigationController()
    }
    
    func initNavigationController() {
        guard let navigationController = self.navigationController else {
            return
        }

        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.navigationBar.backgroundColor = Color.black
        navigationController.navigationBar.barTintColor = Color.whiteSmoke
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black

        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.whiteSmoke!,
            .font: UIFont.systemFont(ofSize: 16)
        ]

        UINavigationBar.appearance().titleTextAttributes = textAttributes
        navigationController.navigationBar.titleTextAttributes = textAttributes
    }


    
}

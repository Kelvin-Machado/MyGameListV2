//
//  BaseViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 02/01/24.
//

import UIKit
import RxSwift
import RxCocoa


class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    func setupBaseUI() {
        initNavigationController()
    }
    
    func initNavigationController() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        let titleTextAttr: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .shadow: NSShadow()
        ]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = Color.primary
        navigationBarAppearance.shadowColor = Color.clear
        navigationBarAppearance.titleTextAttributes = titleTextAttr
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.barTintColor = Color.whiteSmoke
        navigationBar.isTranslucent = false
        
        UINavigationBar.appearance().titleTextAttributes = titleTextAttr
        navigationBar.titleTextAttributes = titleTextAttr
    }

}

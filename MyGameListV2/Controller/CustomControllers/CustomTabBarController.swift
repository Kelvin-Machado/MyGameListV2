//
//  CustomTabBarController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 02/01/24.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    private let dividerHeight: CGFloat = 1.0
    private var dividerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addDivider()
    }

    private func addDivider() {
        guard let selectedItem = tabBar.selectedItem else {
            return
        }

        if let index = tabBar.items?.firstIndex(of: selectedItem) {
            let itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
            let xPosition = CGFloat(index) * itemWidth

            dividerView = UIView(frame: CGRect(x: xPosition, y: -dividerHeight, width: itemWidth, height: dividerHeight))
            dividerView?.backgroundColor = .lightGray
            tabBar.addSubview(dividerView!)
        }
    }

    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        moveDividerToSelectedItem()
    }

    private func moveDividerToSelectedItem() {
        guard let selectedItem = tabBar.selectedItem else {
            return
        }

        if let index = tabBar.items?.firstIndex(of: selectedItem) {
            let itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
            let xPosition = CGFloat(index) * itemWidth

            UIView.animate(withDuration: 0.3) {
                self.dividerView?.frame.origin.x = xPosition
            }
        }
    }
}

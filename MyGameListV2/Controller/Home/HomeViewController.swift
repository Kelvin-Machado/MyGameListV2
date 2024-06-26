//
//  HomeViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 19/12/23.
//

import UIKit

class HomeViewController: BaseViewController {

    lazy private var sampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello World!"
        label.textColor = UIColor.white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.background
        self.view.addSubview(self.sampleLabel)
        self.setUpConstraints()
    }

    func setUpConstraints() {
        let sampleLabelConstraints = [
            self.sampleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sampleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(sampleLabelConstraints)
    }

}

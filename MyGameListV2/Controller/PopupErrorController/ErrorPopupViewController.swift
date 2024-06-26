//
//  ErrorPopupViewController.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 26/01/24.
//

import UIKit

class ErrorPopupViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.black
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.TextColor.primary
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Ops, algo deu errado!"
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.TextColor.primary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        return button
    }()

    private var errorMessage: String?

    init(errorMessage: String) {
        super.init(nibName: nil, bundle: nil)
        self.errorMessage = errorMessage
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.clear
        setupUI()
        displayError()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = Color.black?.withAlphaComponent(0.5)
        }
    }


    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(errorLabel)
        containerView.addSubview(closeButton)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),

            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),

            errorLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            errorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),

            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func displayError() {
        errorLabel.text = errorMessage
    }
    
    @objc private func closeButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = Color.black?.withAlphaComponent(0.5)
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}


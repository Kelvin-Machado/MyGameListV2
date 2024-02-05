//
//  SearchResultViewCell.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 03/01/24.
//

import UIKit

class SearchResultViewCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.primary
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    private let gameCardView: GameCardView = {
        let cardView = GameCardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Color.clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(gameCardView)

        contentView.layer.shadowColor = Color.silver?.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            gameCardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            gameCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gameCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gameCardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }

    func configure(with game: Game?, isLoad: Bool) {
        gameCardView.configure(with: game)
    }
}

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

        containerView
            .top(to: contentView.topAnchor, constant: 16)
            .leading(to: contentView.leadingAnchor, constant: 32)
            .trailing(to: contentView.trailingAnchor, constant: -32)
            .bottom(to: contentView.bottomAnchor, constant: -16)

        gameCardView
            .top(to: containerView.topAnchor)
            .leading(to: containerView.leadingAnchor)
            .trailing(to: containerView.trailingAnchor)
            .bottom(to: containerView.bottomAnchor)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        gameCardView.reset()
    }
    
    func configure(with game: Game?, isLoad: Bool) {
        gameCardView.configure(with: game)
    }
}

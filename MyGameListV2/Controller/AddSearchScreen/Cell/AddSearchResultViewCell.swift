//
//  AddSearchResultViewCell.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 05/02/24.
//

import UIKit

class AddSearchResultViewCell: UITableViewCell {

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

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = Color.silver
        textView.textColor = Color.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        textView.textContainer.lineFragmentPadding = 0
        return textView
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
        containerView.addSubview(descriptionTextView)

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

            descriptionTextView.topAnchor.constraint(equalTo: gameCardView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionTextView.sizeToFit()
    }

    func configure(with game: Game?, isLoad: Bool) {
        gameCardView.configure(with: game)
        descriptionTextView.text = game?.description
    }
}

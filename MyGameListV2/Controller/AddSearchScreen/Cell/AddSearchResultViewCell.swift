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
        textView.isUserInteractionEnabled = false
        textView.textContainerInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Color.clear
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameCardView.reset()
        descriptionTextView.text = ""
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
        
        containerView
            .top(to: contentView.topAnchor, constant: 16)
            .leading(to: contentView.leadingAnchor, constant: 32)
            .trailing(to: contentView.trailingAnchor, constant: -32)
            .bottom(to: contentView.bottomAnchor, constant: -16)
        
        gameCardView
            .top(to: containerView.topAnchor)
            .leading(to: containerView.leadingAnchor)
            .trailing(to: containerView.trailingAnchor)
        
        descriptionTextView
            .top(to:  gameCardView.bottomAnchor, constant: 8)
            .leading(to: containerView.leadingAnchor, constant: 16)
            .trailing(to: containerView.trailingAnchor, constant: -16)
            .bottom(to: containerView.bottomAnchor, constant: -16)
        
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

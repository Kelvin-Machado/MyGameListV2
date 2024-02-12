//
//  GameCardView.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 05/02/24.
//

import UIKit

class GameCardView: UIView {
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.dimGray
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.whiteSmoke
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(gameImageView)
        addSubview(dividerView)
        addSubview(nameLabel)
        
        gameImageView
            .top(to: topAnchor)
            .leading(to: leadingAnchor)
            .trailing(to: trailingAnchor)
            .height(equalTo: gameImageView.widthAnchor, multiplier: 475.0/844.0)
        
        dividerView
            .top(to: gameImageView.bottomAnchor)
            .leading(to: leadingAnchor)
            .trailing(to: trailingAnchor)
            .height(equalTo: 2)
        
        nameLabel
            .top(to: dividerView.bottomAnchor, constant: 16)
            .leading(to: leadingAnchor, constant: 16)
            .trailing(to: trailingAnchor, constant: -16)
            .bottom(to: bottomAnchor, constant: -16)
    }
    
    func configure(with game: Game?) {
        nameLabel.text = game?.name
        loadImage(from: game?.backgroundImage ?? "")
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            // TODO: Adicionar tratamento
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Erro ao baixar a imagem: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.gameImageView.image = image
                }
            }
        }.resume()
    }
    
    func reset() {
        nameLabel.text = nil
        gameImageView.image = nil
    }
}


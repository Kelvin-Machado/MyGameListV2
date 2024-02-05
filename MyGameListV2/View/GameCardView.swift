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
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gameImageView.widthAnchor.constraint(equalTo: gameImageView.heightAnchor, multiplier: 844.0 / 475.0),
            
            dividerView.topAnchor.constraint(equalTo: gameImageView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            nameLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
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
}


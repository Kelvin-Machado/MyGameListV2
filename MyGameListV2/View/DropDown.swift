//
//  DropDown.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/02/24.
//

import UIKit

class DropDown: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Platformas"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Color.black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Color.black
        return imageView
    }()
    
    private let optionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var options: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(arrowImageView)
        addSubview(optionsTableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            optionsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            optionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
    }
    
    func setOptions(_ options: [String]) {
        self.options = options
        optionsTableView.reloadData()
    }
}

extension DropDown: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: adicionar ação para o clique
        print("Selected option: \(options[indexPath.row])")
    }
}


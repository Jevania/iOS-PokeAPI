//
//  PokemonTableViewCell.swift
//  PokeAPIApp
//
//  Created by jevania on 07/11/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonTableViewCell"

    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    
    var pokemonNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(pokemonNameLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let pokemonImageViewConstraints = [
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pokemonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 75),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 75)
        ]
        
        let pokemonNameLabelConstraints = [
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 20),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(pokemonNameLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

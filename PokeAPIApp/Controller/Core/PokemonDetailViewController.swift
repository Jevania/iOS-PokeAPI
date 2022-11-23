//
//  PokemonDetailViewController.swift
//  PokeAPIApp
//
//  Created by jevania on 08/11/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonId: Int?
    var pokemonType: String?
    var pokemonImageUrl: String?
    
    var pokemonNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    
    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    
    var pokemonDescLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private let addToFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Favorite", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pokemon Detail"
        view.backgroundColor = .systemBackground
        
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(pokemonDescLabel)
        view.addSubview(addToFavoriteButton)
        
        addToFavoriteButton.addTarget(self, action: #selector(didTapAddToFavoriteButton), for: .touchUpInside)
        
        configureConstraints()
    }
    
    let viewModel: PokemonManager = PokemonManager()
    
    // MARK: Toast
    @objc private func showToastForAddedToFav() {
        showToast(message: "Added to Favorite!", fontSize: 14)
    }
    
    @objc private func didTapAddToFavoriteButton() {
        print("favorite pokemonNameLabel.text ->", pokemonNameLabel.text ?? "")
        viewModel.addPokemon(pokemonId: pokemonId ?? 0,
                             pokemonName: pokemonNameLabel.text ?? "",
                             pokemonDescription: pokemonDescLabel.text ?? "",
                             PokemonImageUrl: pokemonImageUrl ?? "")
        
        showToastForAddedToFav()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureConstraints(){
        let pokemonNameLabelConstraints = [
            pokemonNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let pokemonImageViewConstraints = [
            pokemonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 30),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 100),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let pokemonDescLabelConstraints = [
            pokemonDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pokemonDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pokemonDescLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 30),
        ]
        
        let addToFavoriteButtonConstraints = [
            addToFavoriteButton.topAnchor.constraint(equalTo: pokemonDescLabel.bottomAnchor, constant: 30),
            addToFavoriteButton.centerXAnchor.constraint(equalTo: pokemonDescLabel.centerXAnchor),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: 40),
            addToFavoriteButton.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(pokemonNameLabelConstraints)
        NSLayoutConstraint.activate(pokemonDescLabelConstraints)
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(addToFavoriteButtonConstraints)
    }
    
}

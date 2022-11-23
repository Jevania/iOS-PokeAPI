//
//  PokemonListViewController.swift
//  PokeAPIApp
//
//  Created by jevania on 07/11/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private var selectedPokemon: PokemonModel = PokemonModel(id: 0, name: "", description: "", imageUrl: "")
    
    private let pokemonListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        
        return tableView
    }()
    
    private var pokemonList = [PokemonModel]()
    
    private var sample = [PokemonModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pokemon List"
        view.backgroundColor = .systemBackground
        
        view.addSubview(pokemonListTableView)
        pokemonListTableView.delegate = self
        pokemonListTableView.dataSource = self
        
        let anonymousFunction = { (fetchedPokemonList: [PokemonModel]) in
            DispatchQueue.main.async {
                self.pokemonList = fetchedPokemonList
                self.pokemonListTableView.reloadData()
            }
        }
        
        PokemonAPI.shared.fetchPokemonList(onCompletion: anonymousFunction)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pokemonListTableView.frame = view.frame
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = pokemonList[indexPath.row]
        
        DispatchQueue.main.async {
            cell.pokemonNameLabel.text = pokemon.name?.capitalized
            cell.pokemonImageView.downloaded(from: pokemon.imageUrl ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPokemon = pokemonList[indexPath.row]
        
        let vc = PokemonDetailViewController()
        
        DispatchQueue.main.async {
            vc.pokemonNameLabel.text = self.selectedPokemon.name?.capitalized
            vc.pokemonDescLabel.text = self.selectedPokemon.description
            vc.pokemonImageUrl = self.selectedPokemon.imageUrl
            vc.pokemonImageView.downloaded(from: vc.pokemonImageUrl ?? "")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

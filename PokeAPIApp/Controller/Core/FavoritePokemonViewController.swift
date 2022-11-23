//
//  FavoritePokemonViewController.swift
//  PokeAPIApp
//
//  Created by jevania on 07/11/22.
//

import UIKit

class FavoritePokemonViewController: UIViewController {
    
    private let favoritePokemonListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Favorite Pokemon"
        view.backgroundColor = .systemBackground
        
        view.addSubview(favoritePokemonListTableView)
        favoritePokemonListTableView.delegate = self
        favoritePokemonListTableView.dataSource = self
    }
    
    let viewModel: PokemonManager = PokemonManager()
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            self.viewModel.getItems()
            self.favoritePokemonListTableView.reloadData()
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoritePokemonListTableView.frame = view.frame
    }
}

extension FavoritePokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritePokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = viewModel.favoritePokemonList[indexPath.row]
        
        DispatchQueue.main.async {
            cell.pokemonNameLabel.text = pokemon.name?.capitalized
            cell.pokemonImageView.downloaded(from: pokemon.imageUrl ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
    
            self.viewModel.favoritePokemonList.remove(at: indexPath.row)
            self.favoritePokemonListTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
            self.favoritePokemonListTableView.reloadData()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

//
//  PokemonVM.swift
//  PokeAPIApp
//
//  Created by jevania on 08/11/22.
//

import Foundation

class PokemonManager {
    
    var favoritePokemonList: [PokemonModel] = [] {
        didSet {
            savePokemonData()
        }
    }
    
    init() {
            getItems()
        }
        
        func getItems() {
            guard
                let data = UserDefaults.standard.data(forKey: "FavoritePokemonList"),
                let savedPokemons = try? JSONDecoder().decode([PokemonModel].self, from: data)
            else { return }
            
            self.favoritePokemonList = savedPokemons
        }
    
    func addPokemon(pokemonId: Int, pokemonName: String, pokemonDescription: String, PokemonImageUrl: String) {
        let newFavPokemon = PokemonModel(id: pokemonId, name: pokemonName, description: pokemonDescription, imageUrl: PokemonImageUrl)
            favoritePokemonList.append(newFavPokemon)
        }
    
    func savePokemonData(){
        if let encodedData = try? JSONEncoder().encode(favoritePokemonList) {
            UserDefaults.standard.set(encodedData, forKey: "FavoritePokemonList")
        }
    }
    
}

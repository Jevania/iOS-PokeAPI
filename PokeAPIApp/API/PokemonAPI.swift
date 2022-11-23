//
//  PokemonAPI.swift
//  PokeAPIApp
//
//  Created by jevania on 08/11/22.
//

import Foundation

final class PokemonAPI{
    
    static let shared = PokemonAPI()
    
    func fetchPokemonList(onCompletion: @escaping ([PokemonModel]) -> ()){
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        let url = URL(string: urlString)!
        
        let pokemon = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data?.removeNullsFrom(string: "null,") else {
                print("Data was nil")
                return
            }
            
            guard let pokemon = try? JSONDecoder().decode([PokemonModel].self, from: data) else {
                print("Couldn't decode JSON")
                return
            }
            
            onCompletion(pokemon)
        }
        pokemon.resume()
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

//
//  PokemonModel.swift
//  PokeAPIApp
//
//  Created by jevania on 08/11/22.
//

import Foundation

struct PokemonModel: Codable{
    var id: Int?
    var name: String?
    var description: String?
    var imageUrl: String?
    
    init(id: Int, name: String, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
    
    func updateCompletion() -> PokemonModel {
        return PokemonModel(id: id ?? 0,
                            name: name ?? "",
                            description: description ?? "",
                            imageUrl: imageUrl ?? "")
    }
}

//"attack": 49,
//"defense": 49,
//"description": "Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.",
//"evolutionChain": [
//{
//"id": "2",
//"name": "ivysaur"
//},
//{
//"id": "3",
//"name": "venusaur"
//}
//],
//"height": 7,
//"id": 1,
//"imageUrl": "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334",
//"name": "bulbasaur",
//"type": "poison",
//"weight": 69

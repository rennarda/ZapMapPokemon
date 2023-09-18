//
//  File.swift
//  
//
//  Created by Andrew Rennard on 18/09/2023.
//

import Foundation
/// Note: this currently mirrors the RemotePokemonDetails, but it allows us to create a data model that best fits the requirement of our app, without being closely coupled to the remote data model.
/// This also gives us the flexibility to change our remote data source without impacting large parts of our app.
public struct PokemonDetails: Decodable {
    let name: String
    let weight: Int
    let height: Int
    let types: [PokemonType]
    let sprites: PokemonSprites
}

public struct PokemonType: Decodable {
    let slot: Int
    let type: PokemonTypeResource
}

public struct PokemonTypeResource: Decodable {
    let name: String
}

public struct PokemonSprites: Decodable {
    let frontDefault: URL
}

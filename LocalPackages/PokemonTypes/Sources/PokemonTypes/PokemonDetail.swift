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
    public init(name: String, weight: Int, height: Int, types: [PokemonType], sprites: PokemonSprites) {
        self.name = name
        self.weight = weight
        self.height = height
        self.types = types
        self.sprites = sprites
    }
    
    public let name: String
    public let weight: Int
    public let height: Int
    public let types: [PokemonType]
    public let sprites: PokemonSprites
}

public struct PokemonType: Decodable {
    public init(slot: Int, type: PokemonTypeResource) {
        self.slot = slot
        self.type = type
    }
    
    public let slot: Int
    public let type: PokemonTypeResource
}

public struct PokemonTypeResource: Decodable {
    public init(name: String) {
        self.name = name
    }
    
    public let name: String
}

public struct PokemonSprites: Decodable {
    public init(frontDefault: URL) {
        self.frontDefault = frontDefault
    }
    
    public let frontDefault: URL
}

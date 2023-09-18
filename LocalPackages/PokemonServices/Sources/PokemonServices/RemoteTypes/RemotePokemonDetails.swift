//
//  RemotePokemonDetails.swift
//  Pokemon
//
//  Created by Ben Rosen on 11/10/2022.
//
import Foundation

public struct RemotePokemonDetails: Decodable {
    let name: String
    let weight: Int
    let height: Int
    let types: [RemotePokemonType]
    let sprites: RemotePokemonSprites
}

public struct RemotePokemonType: Decodable {
    let slot: Int
    let type: RemotePokemonTypeResource
}

public struct RemotePokemonTypeResource: Decodable {
    let name: String
}

public struct RemotePokemonSprites: Decodable {
    let frontDefault: URL
}

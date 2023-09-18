//
//  File.swift
//  
//
//  Created by Andrew Rennard on 18/09/2023.
//

import Foundation
import PokemonTypes

extension Pokemon {
    init(remoteItem: RemotePokemonListItem) {
        self.init(name: remoteItem.name, url: remoteItem.url)
    }
}

extension PokemonDetails {
    init(remoteItem: RemotePokemonDetails) {
        self.init(name: remoteItem.name,
                  weight: remoteItem.weight,
                  height: remoteItem.height,
                  types: remoteItem.types.map({ PokemonType(slot: $0.slot, type: PokemonTypeResource(name: $0.type.name)) }),
                  sprites: PokemonSprites(frontDefault: remoteItem.sprites.frontDefault))
    }
}

//
//  File.swift
//  
//
//  Created by Andrew Rennard on 18/09/2023.
//

import Foundation
/// Note: this currently mirrors the RemotePokemonListItem, but it allows us to create a data model that best fits the requirement of our app, without being closely coupled to the remote data model.
/// This also gives us the flexibility to change our remote data source without impacting large parts of our app.
public struct Pokemon {
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    public let name: String
    public let url: URL
    public var id: String? {
        return url.pathComponents.last
    }
}

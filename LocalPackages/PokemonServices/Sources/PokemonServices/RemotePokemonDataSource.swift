//
//  RemotePokemonDataSource.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation
import PokemonTypes
import Network

public protocol PokemonDataSource {
    func getPokemonList(offset: Int, limit: Int) async throws -> [Pokemon]
    func getPokemonDetails(id: String) async throws -> PokemonDetails
}

public class RemotePokemonDataSource: PokemonDataSource {
    enum Error: Swift.Error {
        case couldNotCreateUrl
    }

    public static let shared = RemotePokemonDataSource(apiClient: APIClient.shared)
    private static let defaultBaseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private let apiClient: APIClientProtocol
    private let baseURL: URL
    
    public init(apiClient: APIClientProtocol, baseURL: URL? = nil) {
        self.apiClient = apiClient
        self.baseURL = baseURL ?? Self.defaultBaseURL
    }

    public func getPokemonList(offset: Int = 0, limit: Int = 0) async throws -> [PokemonTypes.Pokemon] {
        let url = baseURL.appending(path: "pokemon")
            .appending(queryItems:  [URLQueryItem(name: "offset", value: String(offset)),
                                     URLQueryItem(name: "limit", value: String(limit))]
            )
        let listResponse: RemotePokemonList = try await apiClient.get(url: url)
        return listResponse.results.map({ Pokemon(remoteItem: $0)})
    }
    
    public func getPokemonDetails(id: String) async throws -> PokemonTypes.PokemonDetails {
        let url = baseURL.appending(path: "pokemon").appending(path: id)
        let details: RemotePokemonDetails = try await apiClient.get(url: url)
        return PokemonDetails(remoteItem: details)
    }
}

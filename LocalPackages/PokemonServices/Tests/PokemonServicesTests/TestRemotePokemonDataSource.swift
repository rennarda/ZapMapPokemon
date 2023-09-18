//
//  TestPokemonService.swift
//  
//
//  Created by Andrew Rennard on 18/09/2023.
//

import XCTest
@testable import PokemonServices
import Network

final class TestRemotePokemonDataSource: XCTestCase {
    var sut: RemotePokemonDataSource!
    var apiClient: MockAPIClient!
    
    override func setUpWithError() throws {
        apiClient = MockAPIClient()
        sut = RemotePokemonDataSource(apiClient: apiClient)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getList() async {
        apiClient.response = RemotePokemonList(results: [
            RemotePokemonListItem(name: "Pokemon 1", url: URL(string: "http://pokemon.com/1")!),
            RemotePokemonListItem(name: "Pokemon 2", url: URL(string: "http://pokemon.com/2")!),
            RemotePokemonListItem(name: "Pokemon 3", url: URL(string: "http://pokemon.com/3")!),
        ], count: 3)
        
        do {
            let result = try await sut.getPokemonList()
            XCTAssertEqual(apiClient.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon?offset=0&limit=0")
            XCTAssertEqual(result.count, 3)
            XCTAssertEqual(result[0].name, "Pokemon 1")
            XCTAssertEqual(result[0].url.absoluteString, "http://pokemon.com/1")
            XCTAssertEqual(result[1].name, "Pokemon 2")
            XCTAssertEqual(result[1].url.absoluteString, "http://pokemon.com/2")
            XCTAssertEqual(result[2].name, "Pokemon 3")
            XCTAssertEqual(result[2].url.absoluteString, "http://pokemon.com/3")
            
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
    
    func test_getList_withOffsetAndLimit() async {
        apiClient.response = RemotePokemonList(results: [
            RemotePokemonListItem(name: "Pokemon 1", url: URL(string: "http://pokemon.com/1")!),
        ], count: 1)
        
        do {
            let result = try await sut.getPokemonList(offset: 5, limit: 10)
            XCTAssertEqual(apiClient.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon?offset=5&limit=10")
            XCTAssertEqual(result.count, 1)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

}

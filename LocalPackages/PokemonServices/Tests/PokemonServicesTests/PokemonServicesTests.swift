import XCTest
@testable import PokemonServices
import PokemonTypes

final class PokemonServicesTests: XCTestCase {
    func test_mapping_pokemon() {
        let remoteItem = RemotePokemonListItem(name: "Test name", url: URL(string: "http://pokemon.com/test1")!)
        let mappedItem = Pokemon(remoteItem: remoteItem)
        
        XCTAssertEqual(remoteItem.name, mappedItem.name)
        XCTAssertEqual(remoteItem.url.absoluteString, mappedItem.url.absoluteString)
    }
    
    func test_mapping_pokemonDetails() {
        let remoteItem = RemotePokemonDetails(name: "Test name", weight: 123, height: 456, types: [
            RemotePokemonType(slot: 1, type: RemotePokemonTypeResource(name: "resource 1 name")),
            RemotePokemonType(slot: 2, type: RemotePokemonTypeResource(name: "resource 2 name"))                                                                      ],
                                              sprites: RemotePokemonSprites(frontDefault: URL(string: "http://remote.url")!))
        let mappedItem = PokemonDetails(remoteItem: remoteItem)
        
        XCTAssertEqual(remoteItem.name, mappedItem.name)
        XCTAssertEqual(remoteItem.weight, mappedItem.weight)
        XCTAssertEqual(remoteItem.height, mappedItem.height)
        XCTAssertEqual(remoteItem.types.count, mappedItem.types.count)
        XCTAssertEqual(remoteItem.types[0].slot, mappedItem.types[0].slot)
        XCTAssertEqual(remoteItem.types[0].type.name, mappedItem.types[0].type.name)
    }
}

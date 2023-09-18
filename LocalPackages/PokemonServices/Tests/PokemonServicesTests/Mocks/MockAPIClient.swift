//
//  File.swift
//  
//
//  Created by Andrew Rennard on 18/09/2023.
//

import Foundation
import Network

class MockAPIClient: APIClientProtocol {
    var error: Error?
    var response: Decodable?
    var url: URL?
    
    func get<T>(url: URL) async throws -> T where T : Decodable {
        self.url = url
        if let error {
            throw error
        } else {
            return response as! T
        }
    }
}

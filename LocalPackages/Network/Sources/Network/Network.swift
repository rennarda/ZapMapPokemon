// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum APIError: Error, LocalizedError {
    case notImplemented
    case invalidURL
    case invalidResponse
    case responseError(Error)
    case decodingError(Error)
    case encodingError(Error)
    case genericError(Error)
}

public protocol APIClientProtocol {
    /// Perform a `GET` request
    /// - Parameters:
    ///   - url: the URL to request
    /// - Returns: The decoded response type
    func get<T: Decodable>(url: URL) async throws -> T
    
    // NOT IMPLEMENTED: methods for POST, PUT, PATCH, DELETE
}

/// A generic HTTP API Client
public class APIClient: APIClientProtocol {
    public static let shared = APIClient()
    
    /// Perform a request that does not contain a http body
    /// - Parameters:
    ///   - url: the URL to request
    ///   - method: the HTTP method to use
    /// - Returns: The decoded response type
    private func request<T: Decodable>(url: URL, method: HTTPMethod) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return try await perform(request)
    }
    
    /// The main request handler function - all other functions call into this to actually perform the request
    /// - Parameters:
    ///   - request: the `URLRequest` to perform
    /// - Returns: The decoded response type
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
        else {
            //TODO: Parse an API error response
            throw APIError.invalidResponse
        }
        
        do {
            return try T.decode(from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    public func get<T: Decodable>(url: URL) async throws -> T {
        try await request(url: url, method: .get)
    }
}

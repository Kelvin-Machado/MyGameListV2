//
//  APIRequest.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
}

protocol APIRequestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIRequest<T: Decodable>: APIRequestable {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String: String]?

    init(path: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }

    func urlRequest(withBaseURL baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            return nil
        }
        
        guard let path = Bundle.main.path(forResource: "ConfigAPI", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["API_KEY"] as? String else {
            fatalError("API key not found in the configuration file.")
        }
        
        var allParameters = parameters ?? [:]
        allParameters["key"] = apiKey

        urlComponents.queryItems = allParameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }

        guard let url = urlComponents.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

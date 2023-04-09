//
//  BaseService.swift
//  WeatherApp
//
//  Created by Satya Swaroop on 08/04/23.
//

import Foundation

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingFailed
}

class BaseService {

    // MARK: - Generic HTTP method to fetch the data from the Server
func httpRequest<T: Decodable>(urlString: String, method: HTTPMethod, completion: @escaping (Result<T, APIError>) -> Void) {
   
    guard let url = URL(string: urlString) else {
        completion(.failure(.invalidURL))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(.requestFailed))
            return
        }
        
        guard let data = data else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingFailed))
        }
    }.resume()
}
}


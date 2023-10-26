//
//  NetworkService.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case dataDecodingFailed(Error)
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func requestData<T: Decodable>(from url: URL, cacheKey: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(responseType, from: data)
                CacheManager.shared.saveData(data, forKey: cacheKey)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.dataDecodingFailed(error)))
            }
        }.resume()
    }
}

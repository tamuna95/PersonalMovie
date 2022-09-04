//
//  NetworkManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 31.08.22.
//

import Foundation

class NetworkManager {
    let indicator = MoviesViewController()
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Error: \(error)")
            }
            
        }.resume()
    }
    
    
}

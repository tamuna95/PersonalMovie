//
//  NetworkManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 31.08.22.
//

import Foundation


enum Links : String {
    case baseUrl = "https://api.themoviedb.org/3/movie/"
    case genreUrl = "https://api.themoviedb.org/3/genre/movie/list"
    case searchMovie = "https://api.themoviedb.org/3/search/movie"
}

class NetworkManager {
    func requestApi(url : String)-> URL {
        var urlComponent = URLComponents(string: url)
        urlComponent?.queryItems =  [
            URLQueryItem(name: "api_key", value: "849449c28f7f0fcd751e99e02fa006d6"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        var request = URLRequest(url: (urlComponent?.url!)!)
        request.httpMethod = "GET"
        return request.url!
        
    }
    static let shared = NetworkManager()
    var session = URLSession()
    init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }
    
    func get<T: Codable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        let url = requestApi(url: url)
        
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
                print("URL",String(url.path))
            } catch {
                print("Error: \(error)")
            }
            
        }.resume()
    }
    
    
}


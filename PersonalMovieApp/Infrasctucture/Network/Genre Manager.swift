//
//  Genre Manager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

class GenresManager : MoviesManagerProtocol {
    func fetchMovies<GenreModel: Codable>(url: String,completion: @escaping ((GenreModel) -> Void)) {
        NetworkManager.shared.get(url: url) { (result: Result<GenreModel, Error>) in
            switch result {
            case .success(let genres):
                completion(genres)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  MovieManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 31.08.22.
//

import Foundation

protocol MoviesManagerProtocol: AnyObject {
    func fetchMovies<T: Codable>(url : String,completion: @escaping ((T) -> Void))
}

class MoviesManager: MoviesManagerProtocol {
    func fetchMovies<MovieRequest: Codable>(url: String,completion: @escaping ((MovieRequest) -> Void)) {
        NetworkManager.shared.get(url: url) { (result: Result<MovieRequest, Error>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

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



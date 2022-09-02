//
//  MovieListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    func getMoviesList(url : String,completion: @escaping (([MovieViewModel]) -> Void))
    
    init(with moviesManager: MoviesManagerProtocol)
}

class MovieListViewModel : MovieListViewModelProtocol {
    
    let moviesManager : MoviesManagerProtocol
    func getMoviesList(url: String,completion: @escaping (([MovieViewModel]) -> Void)) {
        moviesManager.fetchMovies(url : url) { movie in
            DispatchQueue.main.async {
                let movieViewModels = movie.results.map {MovieViewModel(movie: $0)}
                completion(movieViewModels)
            }
        }
        }
    
    required init(with moviesManager: MoviesManagerProtocol) {
        self.moviesManager = moviesManager
    }
    
}

//
//  MovieListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    func getList(url : String,completion: @escaping (([MovieViewModel]) -> Void))
    
    init(with moviesManager: MoviesManagerProtocol)
}


class MovieListViewModel : MovieListViewModelProtocol {
    required init(with moviesManager: MoviesManagerProtocol) {
        self.moviesManager = moviesManager
        
    }
    
    let moviesManager : MoviesManagerProtocol
    
    func getList(url: String,completion: @escaping (([MovieViewModel]) -> Void)) {
        
        moviesManager.fetchMovies(url : url) { (movie : MovieRequest) in
            DispatchQueue.main.async {
                let movieViewModels = movie.results.map {MovieViewModel(movie: $0)}
                completion(movieViewModels)
            }
        }
    }
}



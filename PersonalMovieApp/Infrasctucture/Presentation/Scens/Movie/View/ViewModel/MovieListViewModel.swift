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


protocol GenreListViewModelProtocol: AnyObject {
    func getList(url : String,completion: @escaping (([GenreViewModel]) -> Void))
    
    init(with genreManager: MoviesManagerProtocol)
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


class GenreListViewModel : GenreListViewModelProtocol {
    required init(with genreManager: MoviesManagerProtocol) {
        self.genreManager = genreManager
    }
    
    let genreManager : MoviesManagerProtocol
    func getList(url: String, completion: @escaping (([GenreViewModel]) -> Void)) {
        genreManager.fetchMovies(url : url) { (genre : GenreModel) in
            DispatchQueue.main.async {
                let genreViewModels = genre.genres.map {GenreViewModel(genre: $0)}
                completion(genreViewModels)
            }
        }
}
    }


protocol SimilarMovieListViewModelProtocol: AnyObject {
    func getList(url : String,completion: @escaping (([MovieViewModel]) -> Void))
    
    init(with movieManager: MoviesManagerProtocol)
}

class SimilarMovieViewModel : SimilarMovieListViewModelProtocol {
    required init(with movieManager: MoviesManagerProtocol) {
        self.movieManager = movieManager
    }
    
    let movieManager : MoviesManagerProtocol
    func getList(url: String, completion: @escaping (([MovieViewModel]) -> Void)) {
        movieManager.fetchMovies(url : url) { (movie : MovieRequest) in
            DispatchQueue.main.async {
                let movieModels = movie.results.map{MovieViewModel(movie: $0)}
                completion(movieModels)
            }
        }
}
    }

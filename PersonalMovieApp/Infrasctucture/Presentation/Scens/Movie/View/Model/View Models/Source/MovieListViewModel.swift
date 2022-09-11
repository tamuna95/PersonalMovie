//
//  MovieListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    associatedtype T
    
    func getList(url : String,completion: @escaping (([T]) -> Void))
    
    init(with moviesManager: TaskManagerProtocol)
}


class MovieListViewModel : MovieListViewModelProtocol {
    typealias T = MovieViewModel
    
    required init(with moviesManager: TaskManagerProtocol) {
        self.moviesManager = moviesManager
        
    }
    
    let moviesManager : TaskManagerProtocol
    
    func getList(url: String,completion: @escaping (([MovieViewModel]) -> Void)) {
        
        moviesManager.fetchMovies(url : url) { (movie : MovieRequest) in
            DispatchQueue.main.async {
                let movieViewModels = movie.results.map {MovieViewModel(movie: $0)}
                completion(movieViewModels)
            }
        }
    }
}



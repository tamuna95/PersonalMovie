//
//  MovieListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation



class MovieListViewModel : ListViewModelProtocol {
    
    
    typealias T = MovieViewModel
    
    required init(with moviesManager: TaskManagerProtocol) {
        self.moviesManager = moviesManager
        
    }
    
    let moviesManager : TaskManagerProtocol
    
    func getList(url: String, query: [String : String], completion: @escaping (([MovieViewModel]) -> Void)) {
        moviesManager.fetchData(url : url,query: query) { (movie : MovieRequest) in
            DispatchQueue.main.async {
                let movieViewModels = movie.results.map {MovieViewModel(movie: $0)}
                completion(movieViewModels)
            }
        }
        
    }
    func getList(url: String,completion: @escaping (([MovieViewModel]) -> Void)) {
        getList(url: url, query: [:],completion: completion)
    }
}
    

//
//  GetLatestMovie.swift
//  PersonalMovieApp
//
//  Created by APPLE on 16.09.22.
//

import Foundation
protocol LatestMovieListViewModelProtocol: AnyObject {
    associatedtype T
    
    func getList(url : String,completion: @escaping ((T) -> Void))
    
    init(with moviesManager: TaskManagerProtocol)
}

class GetLatestMovie : LatestMovieListViewModelProtocol {
    let moviesManager : TaskManagerProtocol
    required init(with moviesManager: TaskManagerProtocol) {
        self.moviesManager = moviesManager
        
    }
    typealias T = LatestMovieViewModel
    func getList(url: String, completion: @escaping ((LatestMovieViewModel) -> Void)) {
        moviesManager.fetchMovies(url : url) { (latestmovie : LatestMovieModel) in
            DispatchQueue.main.async {
                let movieViewModels = LatestMovieViewModel(latestMovie: latestmovie)
                completion(movieViewModels)
            }
        }
    }
    }
    
   


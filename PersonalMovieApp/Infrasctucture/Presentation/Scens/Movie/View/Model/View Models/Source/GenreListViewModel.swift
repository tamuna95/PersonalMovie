//
//  GenreListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 05.09.22.
//

import Foundation

protocol GenreListViewModelProtocol: AnyObject {
    func getList(url : String,completion: @escaping (([GenreViewModel]) -> Void))
    
    init(with genreManager: TaskManagerProtocol)
}

class GenreListViewModel : GenreListViewModelProtocol {
    required init(with genreManager: TaskManagerProtocol) {
        self.genreManager = genreManager
    }
    
    let genreManager : TaskManagerProtocol
    func getList(url: String, completion: @escaping (([GenreViewModel]) -> Void)) {
        genreManager.fetchMovies(url : url) { (genre : GenreModel) in
            DispatchQueue.main.async {
                let genreViewModels = genre.genres.map {GenreViewModel(genre: $0)}
                completion(genreViewModels)
            }
        }
    }
}


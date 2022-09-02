//
//  MovieManager.swift
//  PersonalMovieApp
//
//  Created by APPLE on 31.08.22.
//

import Foundation

protocol MoviesManagerProtocol: AnyObject {
    func fetchMovies(url : String,completion: @escaping ((MovieRequest) -> Void))
}

class MoviesManager: MoviesManagerProtocol {
    func fetchMovies(url: String,completion: @escaping ((MovieRequest) -> Void)) {
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



// let url = "https://api.themoviedb.org/3/movie/" + moviesURL.nowPlaying + "?api_key=\(urlComponents.api_key)&\(urlComponents.language)&\(urlComponents.page)"


//https://api.themoviedb.org/3/movie/now_playing?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US&page=1

struct MoviesUrl {
    var topRated = "top_rated"
    var popular = "popular"
    var similar = "similar"
    var nowPlaying = "now_playing "
    
}

struct UrlComponents {
    var baseURL = "https://api.themoviedb.org/3/"
    var language = "language=en-US"
    var api_key = "849449c28f7f0fcd751e99e02fa006d6"
    var page = "page=1"
    var movie = "movie"
    var tv = "tv"
}
//
//https://api.themoviedb.org/3/tv/top_rated?api_key=849449c28f7f0fcd751e99e02fa006d6
//https://api.themoviedb.org/3/movie/100/similar?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US&page=1
//



//
//  MovieViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation

class MovieViewModel {
    private var isLoading: Bool = false
    private  var movie : MovieModel
    init(movie : MovieModel){
        self.movie = movie
        
    }
    var title : String {
        movie.title
    }
    var imdb : Double {
        movie.rating
        
    }
    var releaseDate : String {
        movie.releaseDate
    }
    var posterPath : String {
        movie.posterPath
    }
    var overview : String {
        movie.overview
    }
    var id : [Int] {
        movie.id
    }
    var movieID : Int {
        movie.movieID
    }
    
}

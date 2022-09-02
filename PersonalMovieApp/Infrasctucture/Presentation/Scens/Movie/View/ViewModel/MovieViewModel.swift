//
//  MovieViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation

class MovieViewModel {
   private  var movie : MovieModel
    init(movie : MovieModel){
        self.movie = movie
        
    }
    var title : String {
        movie.title
    }
    var imdb : String {
        String(movie.rating)
        
    }
    var releaseDate : String {
        movie.releaseDate
    }
    var posterPath : String {
        movie.posterPath
    }
}

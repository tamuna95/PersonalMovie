//
//  URLItems.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation


struct UrlItems {
    
    let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US&page=1"
    let popular = "https://api.themoviedb.org/3/movie/popular?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US&page=1"
    
    let poster =  "https://image.tmdb.org/t/p/w500"
    let topRated =  "https://api.themoviedb.org/3/movie/top_rated?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US&page=1"
    let genre = "https://api.themoviedb.org/3/genre/movie/list?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US"
   let video = "https://api.themoviedb.org/3/movie/756999/videos?api_key=849449c28f7f0fcd751e99e02fa006d6&language=en-US"
    
}
//youtube - https://www.youtube.com/watch?v=key

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



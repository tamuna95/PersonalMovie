//
//  LatestMovieViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 16.09.22.
//

import Foundation
class LatestMovieViewModel {
    var latestMovie : LatestMovieModel
    init(latestMovie : LatestMovieModel) {
        self.latestMovie = latestMovie
    }
    var title : String {
        latestMovie.title
    }
    var posterPath : String? {
        latestMovie.posterPath
    }
    var id : Int {
        latestMovie.id
    }
    var overview : String {
        latestMovie.overview
    }
}

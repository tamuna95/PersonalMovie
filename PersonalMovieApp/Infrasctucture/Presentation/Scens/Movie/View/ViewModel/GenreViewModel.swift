//
//  GenreViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

class GenreViewModel {
    private var genre : Genres
    init(genre : Genres) {
        self.genre = genre
    }
    var id : Int {
        genre.id
    }
    var name : String {
        genre.name
    }
}

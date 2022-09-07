//
//  GenreModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

struct GenreModel: Codable {
    let genres : [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}

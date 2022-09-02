//
//  MovieModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 31.08.22.
//

import Foundation

struct MovieRequest : Codable {
    let results : [MovieModel]
}
struct MovieModel: Codable {
    
    let id: Int
    let posterPath: String
    var videoPath: String?
    let backdrop: String
    let title: String
    var releaseDate: String
    var rating: Double
    let overview: String
    
    private enum CodingKeys: String, CodingKey {
        case id,
             posterPath = "poster_path",
             videoPath,
             backdrop = "backdrop_path",
             title,
             releaseDate = "release_date",
             rating = "vote_average",
             overview
    }
    
    
    
}

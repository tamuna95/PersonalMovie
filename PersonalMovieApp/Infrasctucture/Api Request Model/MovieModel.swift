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
    
    let id: [Int]
    let posterPath: String?
    var videoPath: String?
    let title: String
    var releaseDate: String?
    var rating: Double?
    let overview: String?
    let movieID : Int
//    let backdrop : String
    private enum CodingKeys: String, CodingKey {
        case id = "genre_ids",
             posterPath = "poster_path",
//             backdrop = "backdrop_path",
             videoPath,
             title,
             movieID = "id",
             releaseDate = "release_date",
             rating = "vote_average",
             overview
    }
    
    
    
}

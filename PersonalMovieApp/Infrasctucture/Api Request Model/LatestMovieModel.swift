//
//  LatestMovieModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 16.09.22.
//

import Foundation

struct LatestMovieModel : Codable {
    var title : String
    var posterPath : String?
    var id : Int
    var overview : String
    private enum CodingKeys: String, CodingKey {
        case title,
             id,
             overview,
             posterPath = "poster_path"
             
    }
}

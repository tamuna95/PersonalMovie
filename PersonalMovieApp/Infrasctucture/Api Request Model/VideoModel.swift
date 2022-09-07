//
//  VideoModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

struct VideoModel : Codable {
    var results : [Video]
}
struct Video : Codable {
    var key : String
}

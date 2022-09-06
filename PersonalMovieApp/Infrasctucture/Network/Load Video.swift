//
//  Load Video.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

class LoadVideo : MoviesManagerProtocol {
    func fetchMovies<VideoModel>(url: String, completion: @escaping ((VideoModel) -> Void)) where VideoModel : Decodable, VideoModel : Encodable {
        NetworkManager.shared.get(url: url) { (result: Result<VideoModel, Error>) in
            switch result {
            case .success(let videos):
                completion(videos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

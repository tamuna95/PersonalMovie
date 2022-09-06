//
//  VideoListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

protocol VideoListViewModelProtocol: AnyObject {
    func getVideoList(url : String,completion: @escaping (([VideoViewModel]) -> Void))
    
    init(with videoManager: MoviesManagerProtocol)
}

    
class VideoListViewModel : VideoListViewModelProtocol {
    let videosManager : MoviesManagerProtocol
    
    
    func getVideoList(url: String, completion: @escaping (([VideoViewModel]) -> Void)) {
        videosManager.fetchMovies(url: url) { (video : VideoModel) in
            DispatchQueue.main.async {
                let videosViewModels = video.results.map {VideoViewModel(video: $0)}
                completion(videosViewModels)
            }
            
        }
    }
    required init(with videosManager: MoviesManagerProtocol) {
        self.videosManager = videosManager
    }
    
    
}


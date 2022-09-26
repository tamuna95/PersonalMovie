//
//  VideoListViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation


class VideoListViewModel : ListViewModelProtocol {
    
    typealias T = VideoViewModel
    
    let videosManager : TaskManagerProtocol
    
    
    func getList(url: String, completion: @escaping (([VideoViewModel]) -> Void)) {
        videosManager.fetchData(url: url) { (video : VideoModel) in
            DispatchQueue.main.async {
                let videosViewModels = video.results.map {VideoViewModel(video: $0)}
                completion(videosViewModels)
            }
            
        }
    }
    func getList(url: String, query: [String : String], completion: @escaping (([VideoViewModel]) -> Void)) {
        getList(url: url, query: [:],completion: completion)
        
    }
    
    required init(with videosManager: TaskManagerProtocol) {
        self.videosManager = videosManager
    }
    
    
}


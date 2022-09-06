//
//  VideoViewModel.swift
//  PersonalMovieApp
//
//  Created by APPLE on 06.09.22.
//

import Foundation

class VideoViewModel {
    private var video : Video
    init(video :Video) {
        self.video = video
    }
    var videoKey : String {
        video.key
    }
}

//
//  PlayerViewController.swift
//  PersonalMovieApp
//
//  Created by APPLE on 05.09.22.
//

import UIKit
import youtube_ios_player_helper_swift

class PlayerViewController: UIViewController, YTPlayerViewDelegate{

    @IBOutlet weak var VideoPlayerView: YTPlayerView!
    var key : String = " "
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VideoPlayerView.delegate = self
        print("Key \(key)")
        VideoPlayerView.load(videoId: key, playerVars: ["playsinline": "1"])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: false, completion: nil)

    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        VideoPlayerView.playVideo()
    }
    
}

//
//  VideoView.swift
//  Reddit
//
//  Created by rytis razmus on 13/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoView: UIView {
    //TODO: add player controls
    private  let playerView = PlayerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
        translatesAutoresizingMaskIntoConstraints = false
        playerView.fillContainer(layoutGuide: safeAreaLayoutGuide)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadVideo(urlString: String){
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        playerView.player = player
        addLooper()
        player.play()
    }
    
    private func addLooper(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerView.player?.currentItem, queue: .main) { [weak self] notification in
            self?.playerView.player?.seek(to: CMTime.zero)
            self?.playerView.player?.play()
        }
    }
    
}


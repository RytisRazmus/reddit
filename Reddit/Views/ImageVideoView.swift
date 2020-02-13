//
//  ImageVideoView.swift
//  Reddit
//
//  Created by rytis razmus on 13/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ImageVideoView: UIView {
    
    private let postImageView = ImageLoadingView()
    private let videoView = VideoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageView(urlString: String){
        videoView.removeFromSuperview()
        addSubview(postImageView)
        postImageView.fillContainer(layoutGuide: safeAreaLayoutGuide)
        // TODO: handle error
        postImageView.loadImageWithUrl(urlString.htmlDecoded) { (error) in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self?.errorThrown(error: error)
//                }
//            }
        }
    }
    
    func setVideoView(urlString: String){
        postImageView.removeFromSuperview()
        addSubview(videoView)
        videoView.fillContainer(layoutGuide: safeAreaLayoutGuide)
        
        videoView.loadVideo(urlString: urlString)
    }
    
}

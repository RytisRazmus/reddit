//
//  Preview.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct Preview: Codable {
    let images: [Image]
    let redditVideo: RedditVideo?
    
    enum CodingKeys: String, CodingKey {
        case images
        case redditVideo = "reddit_video_preview"
    }
}

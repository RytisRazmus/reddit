//
//  Media.swift
//  Reddit
//
//  Created by rytis razmus on 13/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct Media: Codable {
    let redditVideo: RedditVideo?
    
    enum CodingKeys: String, CodingKey {
        case redditVideo = "reddit_video"
    }
}

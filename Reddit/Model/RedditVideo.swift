//
//  RedditVideo.swift
//  Reddit
//
//  Created by rytis razmus on 13/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct RedditVideo: Codable{
    let fallbackUrl: String?
    let dashUrl: String?
    let hlsUrl: String?
    let duration: Int
    let isGif: Bool?
    let height: Int
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case fallbackUrl = "fallback_url"
        case dashUrl = "dash_url"
        case hlsUrl = "hls_url"
        case duration
        case isGif = "is_gif"
        case height
        case width
    }
}

//
//  PostData.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PostData: Codable {
    
    let title: String
    let subreddit: String
    let ups: Int
    let score: Int
    let author: String
    let name: String
    let numComments: Int
    let createdUtc: Double
    let preview: Preview?
    let selftext: String
    var subImage: String?
    var imageScaledHeight: CGFloat?
    let secureMediaEmbed: SecureMediaEmbed?
    let secureMedia: SecureMedia?
    let media: Media?
    let url: String?
    var videoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subreddit
        case ups
        case score
        case author
        case name
        case numComments = "num_comments"
        case createdUtc = "created_utc"
        case preview
        case selftext
        case subImage
        case imageScaledHeight
        case secureMediaEmbed = "secure_media_embed"
        case secureMedia = "secure_media"
        case media
        case url
        case videoUrl
    }
    
}

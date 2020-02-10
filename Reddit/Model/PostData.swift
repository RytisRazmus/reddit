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
    private let author: String
    let name: String
    let numComments: Int
    let createdUtc: Double
    let preview: Preview?
    let selftext: String
    var subImage: String?
    var imageScaledHeight: CGFloat?
    
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
    }
    
    func getAuthor() -> String {
        return "u/" + author
    }
    
}

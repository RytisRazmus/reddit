//
//  SecureMediaEmbed.swift
//  Reddit
//
//  Created by rytis razmus on 13/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct SecureMediaEmbed: Codable {
    let height: Int?
    let width: Int?
    let mediaDomainUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case mediaDomainUrl = "media_domain_url"
    }
    
}

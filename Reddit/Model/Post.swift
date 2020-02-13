//
//  Post.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    private let kind: String
    var data: Dataa
    
}
struct Dataa: Codable {
    
    var children: [Children]
    
}

//
//  NetworkError.swift
//  Reddit
//
//  Created by rytis razmus on 10/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case badURL
    case badRequest
    case badData
    case connectonOffline
    
    var description: String {
        switch self {
        case .badRequest:
            return "bad request"
        case .badURL:
            return "bad url"
        case .connectonOffline:
            return "no internet connection"
        case .badData:
            return "bad data"
        }
    }
    
}

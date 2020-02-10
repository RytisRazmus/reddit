//
//  APIClient.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

class APIClient: DataFetcher {
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var request: URLRequest?
    
    func fetch(urlString: String, completion: @escaping (Data?, NetworkError?) -> () ){
        guard let url = URL(string: urlString) else { completion(nil, .badURL); return }
        request = URLRequest(url: url)
        guard let request = request else { completion( nil, .badRequest); return }
        dataTask = session.dataTask(with: request) { [weak self] (data, response, error)  in
            
            defer {
                self?.dataTask = nil
            }
            
            if error != nil {
                completion(nil, .connectonOffline)
                return
            }
            
            completion(data, nil)
        }
        dataTask?.resume()
    }
}

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

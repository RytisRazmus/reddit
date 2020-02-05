//
//  APIClient.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

class APIClient{
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var request: URLRequest?
    
    func fetch(redditUrlString: String, completion: @escaping (Data?) -> () ){
        guard let url = URL(string: redditUrlString) else { return }
        request = URLRequest(url: url)
        guard let r = request else {
            return
        }
        dataTask = session.dataTask(with: r) { [weak self] (data, response, error)  in
            defer {
                self?.dataTask = nil
            }
            if let d = data {
                completion(d)
            } else {
                completion(nil)
            }
        }
        dataTask?.resume()
    }
}

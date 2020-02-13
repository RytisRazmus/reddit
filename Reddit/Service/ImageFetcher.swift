//
//  Imagefetcher.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ImageFetcher {
    
    func fetch(urlString: String, completion: @escaping (UIImage?, NetworkError?) -> ()) {
        if let imageFromCache = ImageCache.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(imageFromCache, nil)
            return
        }
        fetchImageFromAPI(urlString: urlString) { (data, error)  in
            if let data = data, let image = UIImage(data: data) {
                completion(image, error)
            }
        }
    }
    
    private func fetchImageFromAPI(urlString: String, completion: @escaping (Data?, NetworkError?) -> ()){
        let client = APIClient()
        client.fetch(urlString: urlString) { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    ImageCache.imageCache.setObject(imageToCache, forKey: urlString as AnyObject, cost: unwrappedData.count)
                    completion(unwrappedData, error)
                    return
                }
                completion(nil, error)
            })
        }
    }
}


//
//  Imagefetcher.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ImageFetcher {
    func loadImageWithUrl(_ urlString: String?, completion: ((UIImage?) -> ())?) {
           let session = URLSession(configuration: .default)
           var dataTask: URLSessionDataTask?
           guard let urlS = urlString else {
               completion?(nil)
               return }
           guard let url = URL(string: urlS) else {
               completion?(nil)
               return }
           // retrieves image from cahche if it's available
           if let imageFromCache = ImageCache.imageCache.object(forKey: url as AnyObject) as? UIImage {
               completion?(imageFromCache)
               return
           }
           
           //get image from url
           dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
               if error != nil {
                   print(error?.localizedDescription ?? "error loading image")
                   completion?(nil)
                   return
               }

               DispatchQueue.main.async(execute: {
                   if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                       ImageCache.imageCache.setObject(imageToCache, forKey: url as AnyObject, cost: unwrappedData.count)
                       completion?(imageToCache)
                   }
               })
           })
           dataTask?.resume()
       }
}


//
//  ImageLoader.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ImageLoadingView: UIImageView {

    private let fetcher = ImageFetcher()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImageWithUrl(_ urlString: String?, completion: @escaping (NetworkError?) -> () ) {
        image = nil
        guard let urlString = urlString else { return completion(.badURL) }
        fetcher.fetch(urlString: urlString) { [weak self] (fetchedImage, error) in
            if let fetchedImage = fetchedImage {
                self?.image = fetchedImage
            }
            completion(error)
        }
    }

}

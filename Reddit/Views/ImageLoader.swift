//
//  ImageLoader.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {

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
    
    func loadImageWithUrl(_ urlString: String?, completion: (() -> ())?) {
        image = nil
        fetcher.loadImageWithUrl(urlString) { [weak self] (img) in
            self?.image = img
            completion?()
        }
    }

}

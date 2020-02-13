//
//  Image.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

struct Image: Codable {
    let source: Source
    let variants: Variants?
}

extension Image {
    func calculateImageHeight() -> CGFloat {
        let cellWidth = UIScreen.main.bounds.width
        let newHeight = cellWidth / source.width * source.height
        return newHeight
    }
}

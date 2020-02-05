//
//  PostCellViewModel.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

struct PostCellViewModel {
    func calculateImageHeight(_ w: CGFloat?, _ h: CGFloat?) -> CGFloat {
        guard let w = w, let h = h else { return 0}
        let cellWidth = UIScreen.main.bounds.width
        let newHeight = cellWidth / w * h
        return newHeight
    }
}

//
//  PostLabel.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PostLabel: UILabel {

    init(font: UIFont, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        textColor = .black
        self.font = font
        self.textAlignment = alignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

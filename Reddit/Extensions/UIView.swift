//
//  UIView.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillContainer(layoutGuide: UILayoutGuide){
        self.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
    }
    
}

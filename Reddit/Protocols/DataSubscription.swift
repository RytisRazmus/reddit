//
//  DataSubscription.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

protocol DataSubscription: AnyObject {
    
    func dataUpdated()
    func errorThrown(error: NetworkError)
    
}

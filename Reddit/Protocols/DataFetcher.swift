//
//  DataFetcher.swift
//  Reddit
//
//  Created by rytis razmus on 05/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

protocol DataFetcher: AnyObject{
    
    func fetch(urlString: String, completion: @escaping (Data?, NetworkError?) -> ())
    
}

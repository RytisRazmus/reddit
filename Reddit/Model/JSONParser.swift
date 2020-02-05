//
//  JsonParser.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

struct JSONParser {
    
    private func decodeData<T : Decodable>(d: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: d)
            return decoded
        } catch let err {
            print(err)
            return nil
        }
    }
    
    func decodeToPostData(d: Data) -> [PostData]? {
        if let decoded: Post = decodeData(d: d){
            let mapedPostData = decoded.data.children.map({$0.data})
            return mapedPostData
        }
        return nil
    }
    
//    func decodeSubData(d: Data) -> SubData? {
//        let subData: SubData? = decodeData(d: d)
//        return subData
//    }
}

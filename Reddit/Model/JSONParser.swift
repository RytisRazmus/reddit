//
//  JsonParser.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

struct JSONParser {
    
    private func decodeData<T : Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let err {
            print(err)
            return nil
        }
    }
    
    func decodeToPostData(data: Data) -> [PostData]? {
        if let decoded: Post = decodeData(data: data){
            let postsData = decoded.data.children.map({$0.data})
            return postsData
        }
        return nil
    }
    
//    func decodeSubData(d: Data) -> SubData? {
//        let subData: SubData? = decodeData(d: d)
//        return subData
//    }
}

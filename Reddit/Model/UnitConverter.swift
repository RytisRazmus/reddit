//
//  File.swift
//  Reddit
//
//  Created by rytis razmus on 11/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

struct UnitConverter {
    
    static func convertToKs(_ upvotes: Int) -> String{
        if upvotes < 1000 {
            return "\(upvotes)"
        }
        let ks = Int(upvotes / 1000)
        let quotient = 1000 * ks
        let deci = upvotes % quotient / 100
        return "\(ks).\(deci)k"
    }
    
    static func numberWithColons(_ number: Int) -> String {
        if number == 0 {
            return "0"
        }
        var n = number
        var nrWithColons = ""
        var i = 0
        while n != 0 {
            let mod = n % 10
            n = (n - mod) / 10
            if i > 2 {
                nrWithColons.insert(",", at: nrWithColons.startIndex)
                i = 0
            }
            i += 1
            nrWithColons.insert(Character(String(mod)), at: nrWithColons.startIndex)
        }
        return nrWithColons
    }
}

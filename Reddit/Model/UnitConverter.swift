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
    
    static func convertTime(_ timeCreated: Double) -> String{
        let timestamp = NSDate().timeIntervalSince1970
        let timeAgo = timestamp - timeCreated
        let minutes = Int(timeAgo / 60)
        let hours = Int(timeAgo / 3600)
        let days = Int(timeAgo / (3600 * 24))
        let months = Int(timeAgo / (24 * 3600 * 30))
        let years = Int(timeAgo / (24 * 3600 * 30 * 12))
        if timeAgo < 60 {
            return "\(Int(timeAgo))s ago"
        } else if minutes < 60 {
            return "\(minutes)min ago"
        } else if hours < 24 {
            return "\(hours)h ago"
        } else if days < 30 {
            return "\(days)d ago"
        } else if months < 12{
            if months > 1 {
                return "\(months) months ago"
            } else {
                return "\(months) month ago"
            }
        } else {
            return "\(years)y ago"
        }
    }
    
}

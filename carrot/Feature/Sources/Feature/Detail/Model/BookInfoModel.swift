//
//  File.swift
//  
//
//  Created by 최승민 on 9/22/24.
//

import Foundation

struct BookInfoModel: Hashable {
    let year, rating, desc, price: String?
    let url: String?
    let pages: String?
    
    static func == (lhs: BookInfoModel, rhs: BookInfoModel) -> Bool {
        if lhs.desc == rhs.desc && lhs.price == rhs.price && lhs.url == rhs.url { return true }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(price)
        hasher.combine(desc)
        hasher.combine(url)
    }
}

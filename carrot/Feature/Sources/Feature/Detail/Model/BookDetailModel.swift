//
//  BookDetailModel.swift
//
//
//  Created by 최승민 on 9/21/24.
//

import Foundation

struct BookHeaderModel: Hashable {
    let title, subtitle, authors: String
    let publisher: String?
    let image: String
    
    static func == (lhs: BookHeaderModel, rhs: BookHeaderModel) -> Bool {
        if lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.publisher == rhs.publisher { return true }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(publisher)
    }
}

//
//  SearchPresentationModel.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

struct SearchPresentationModel: Hashable {
    var imageURL: String
    var title: String
    var subTitle: String
    var price: String
    var id: String
    
    static func == (lhs: SearchPresentationModel, rhs: SearchPresentationModel) -> Bool {
        if lhs.imageURL == rhs.imageURL && lhs.title == rhs.title && lhs.subTitle == rhs.subTitle && lhs.price == rhs.price && lhs.id == rhs.id {
            return true
        }
        
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
        hasher.combine(title)
        hasher.combine(subTitle)
        hasher.combine(price)
        hasher.combine(id)
    }
}

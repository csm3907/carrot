//
//  Book.swift
//  
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

public struct Book {
    public var imageURL: String
    public var title: String
    public var subTitle: String
    public var price: String
    public var id: String
    
    public init(imageURL: String, title: String, subTitle: String, price: String, id: String) {
        self.imageURL = imageURL
        self.title = title
        self.subTitle = subTitle
        self.price = price
        self.id = id
    }
}

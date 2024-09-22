//
//  BookDetail.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Foundation

public struct BookDetail {
    public var imageURL: String
    public var title: String
    public var subTitle: String
    public var price: String
    public var year, rating, desc: String?
    public var pdf: [String: String]
    public var url: String?
    public var publisher: String
    public var authors: String
    public var pages: String?
    
    public init(imageURL: String, title: String, subTitle: String, price: String, year: String?, rating: String?, desc: String?, pdf: [String : String], url: String?, publisher: String, authors: String, pages: String?) {
        self.imageURL = imageURL
        self.title = title
        self.subTitle = subTitle
        self.price = price
        self.year = year
        self.rating = rating
        self.desc = desc
        self.pdf = pdf
        self.url = url
        self.publisher = publisher
        self.authors =  authors
        self.pages = pages
    }
}

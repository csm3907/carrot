//
//  BookSearchListDTO.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

import Domain

struct BookSearchListDTO: Codable {
    let total, page: String?
    let books: [BookDTO]
}

struct BookDTO: Codable {
    let title, subtitle, isbn13, price: String?
    let image: String?
    let url: String?
    
    func toDomain() -> Book {
        return Book(
            imageURL: image ?? "",
            title: title ?? "",
            subTitle: subtitle ?? "",
            price: price ?? "",
            id: isbn13 ?? ""
        )
    }
}

//
//  BookSearchListDTO.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

import Domain

public struct BookSearchListDTO: Codable {
    let total, page: String?
    let books: [BookDTO]
    
    public struct BookDTO: Codable {
        let title, subtitle, isbn13, price: String?
        let image: String?
        let url: String?
    }
    
    public func toDomain() -> [Book] {
        return books.map {
            Book.init(
                imageURL: $0.image ?? "",
                title: $0.title ?? "",
                subTitle: $0.subtitle ?? "",
                price: $0.price ?? "",
                id: $0.isbn13 ?? "",
                total: total ?? "0"
            )
        }
    }
}



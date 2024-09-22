//
//  BookDetailDTO.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Foundation

import Domain

public struct BookDetailDTO: Codable {
    let error, title, subtitle, authors: String?
    let publisher, isbn10, isbn13, pages: String?
    let year, rating, desc, price: String?
    let image: String?
    let url: String?
    let pdf: [String: String]?
    
    public func toDomain() -> BookDetail {
        return .init(
            imageURL: image ?? "",
            title: title ?? "",
            subTitle: subtitle ?? "",
            price: price ?? "",
            year: year,
            rating: rating,
            desc: desc,
            pdf: pdf ?? [:],
            url: url,
            publisher: publisher ?? "",
            authors: authors ?? "",
            pages: pages
        )
    }
}

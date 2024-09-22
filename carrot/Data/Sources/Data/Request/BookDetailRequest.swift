//
//  BookDetailRequest.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Core

import Foundation

struct BookDetailRequest: Request {
    typealias Output = BookDetailDTO

    let endpoint: URL
    let method: HTTPMethod
    let header: HTTPHeader
    let query: QueryItems

    init(_ url: URL, searchID: String) {
        var path = "/books/\(searchID)"
        endpoint = url.appendingPathComponent(path)
        method = .get
        header = [:]
        query = [:]
    }
}

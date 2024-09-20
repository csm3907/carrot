//
//  SearchRequest.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Core

import Foundation

struct SearchRequest: Request {
    typealias Output = BookSearchListDTO

    let endpoint: URL
    let method: HTTPMethod
    let header: HTTPHeader
    let query: QueryItems

    init(_ url: URL, pages: Int, search: String) {
        var path = "/search/\(search)"
        if pages != 0 {
            path = path + "/\(pages)"
        }
        endpoint = url.appendingPathComponent(path)
        method = .get
        header = [:]
        query = [:]
    }
}

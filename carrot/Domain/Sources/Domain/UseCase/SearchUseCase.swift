//
//  SearchUseCase.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Core

import Combine
import Foundation

public class SearchUseCase {
    private var page: Int = 0
    
    @Inject private var searchRepository: SearchRepository

    public init() {}
}

public extension SearchUseCase {
    func searchBookList(search: String) -> AnyPublisher<[Book], Error> {
        let pagination = page
        page += 1
        return searchRepository.searchBookInfo(page: pagination, search: search)
    }
}

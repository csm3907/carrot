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
    private var total: Int = 0
    
    @Inject private var searchRepository: SearchRepository

    public init() {}
}

public extension SearchUseCase {
    func searchBookList(search: String, isMore: Bool = false) -> AnyPublisher<[Book], Error> {
        if !isMore {
            page = 0
            total = 0
        }
        if total > 0, page >= total {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return searchRepository.searchBookInfo(page: page, search: search)
            .handleEvents(receiveOutput: { [weak self] bookList in
                guard let self else { return }
                self.page += bookList.count + 1
                self.total = Int(bookList.first?.total ?? "0") ?? 0
            })
            .eraseToAnyPublisher()
    }
}

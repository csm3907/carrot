//
//  BookDetailUseCase.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Core

import Combine
import Foundation

public class BookDetailUseCase {
    @Inject private var bookDetailRepository: BookDetailRepository

    public init() {}
}

public extension BookDetailUseCase {
    func fetchBookDetail(searchID: String)  -> AnyPublisher<BookDetail, Error> {
        return bookDetailRepository.fetchBookDetail(searchID: searchID)
            .eraseToAnyPublisher()
    }
}

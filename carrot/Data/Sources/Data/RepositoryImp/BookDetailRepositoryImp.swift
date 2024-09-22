//
//  BookDetailRepositoryImp.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Core
import Domain

import Combine
import Foundation

public final class BookDetailRepositoryImp: BaseRepository, BookDetailRepository {
    private let baseURL: URL

    public init(baseURL: URL, network: Network) {
        self.baseURL = baseURL
        super.init(network: network)
    }
}

public extension BookDetailRepositoryImp {
    func fetchBookDetail(searchID: String) -> AnyPublisher<BookDetail, any Error> {
        let request = BookDetailRequest(baseURL, searchID: searchID)
        return send(request)
            .map { $0.output.toDomain() }
            .eraseToAnyPublisher()
    }
}

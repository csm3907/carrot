//
//  File.swift
//  
//
//  Created by 최승민 on 9/20/24.
//

import Core
import Domain

import Combine
import Foundation

public final class SearchRepositoryImp: BaseRepository, SearchRepository {
    private let baseURL: URL

    public init(baseURL: URL, network: Network) {
        self.baseURL = baseURL
        super.init(network: network)
    }
}

public extension SearchRepositoryImp {
    func searchBookInfo(page: Int, search: String) -> AnyPublisher<[Book], Error> {
        let request = SearchRequest(baseURL, pages: page, search: search)
        return send(request)
            .map { $0.output.toDomain() }
            .eraseToAnyPublisher()
    }
}

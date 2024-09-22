//
//  SearchRepositoryMockImp.swift
//  carrotTests
//
//  Created by 최승민 on 9/22/24.
//

import Core
import Domain
@testable import carrot

import Foundation
import Combine
import Data

enum SearchTestError: Error {
    case decodeError
    case makeDataError
}

class SearchRepositoryMockImp: BaseRepository, SearchRepository {
    func searchBookInfo(page: Int, search: String) -> AnyPublisher<[Book], any Error> {
        return Future<[Book], Error> { promise in
            let tempData = page == 0 ? MockData.mockRawDataSearch.data(using: .utf8) : MockData.mockRawDataSearchMore.data(using: .utf8)
            if let data = tempData {
                do {
                    let searchData = try JSONDecoder().decode(BookSearchListDTO.self, from: data)
                    let search = searchData.toDomain()
                    promise(.success(search))
                } catch {
                    promise(.failure(SearchTestError.decodeError))
                }
            } else {
                promise(.failure(SearchTestError.makeDataError))
            }
        }.eraseToAnyPublisher()
    }
}

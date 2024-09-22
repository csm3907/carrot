//
//  DetailRepositoryMockImp.swift
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

enum DetailTestError: Error {
    case decodeError
    case makeDataError
}

class DetailRepositoryMockImp: BaseRepository, BookDetailRepository {
    func fetchBookDetail(searchID: String) -> AnyPublisher<BookDetail, any Error> {
        return Future<BookDetail, Error> { promise in
            if let data = MockData.mockRawDataDetail.data(using: .utf8) {
                do {
                    let detailData = try JSONDecoder().decode(BookDetailDTO.self, from: data)
                    let details = detailData.toDomain()
                    promise(.success(details))
                } catch {
                    promise(.failure(DetailTestError.decodeError))
                }
            } else {
                promise(.failure(DetailTestError.makeDataError))
            }
        }.eraseToAnyPublisher()
    }
}

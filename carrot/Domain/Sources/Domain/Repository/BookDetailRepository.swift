//
//  BookDetailRepository.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Combine
import Foundation

public protocol BookDetailRepository {
    func fetchBookDetail(searchID: String) -> AnyPublisher<BookDetail, Error>
}

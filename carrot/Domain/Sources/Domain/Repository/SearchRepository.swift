//
//  SearchRepository.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Combine
import Foundation

public protocol SearchRepository {
    func searchBookInfo(page: Int, search: String) -> AnyPublisher<[Book], Error>
}

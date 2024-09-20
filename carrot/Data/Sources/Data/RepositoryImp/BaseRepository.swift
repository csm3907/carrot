//
//  BaseRepository.swift
//  
//
//  Created by 최승민 on 9/20/24.
//

import Core

import Combine
import Foundation

open class BaseRepository {
    private let network: Network

    public init(network: Network) {
        self.network = network
    }
}

public extension BaseRepository {
    func send<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error> {
        return network.send(request).eraseToAnyPublisher()
    }
}

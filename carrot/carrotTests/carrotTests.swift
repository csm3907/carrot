//
//  carrotTests.swift
//  carrotTests
//
//  Created by 최승민 on 9/20/24.
//


import Domain
import Core

import XCTest
import Combine
@testable import carrot

final class carrotTests: XCTestCase {
    
    var network: Network!
    var searchRepository: SearchRepository!
    let useCase = SearchUseCase()
    var cancellables: Set<AnyCancellable> = .init()

    override func setUpWithError() throws {
        configureContainer()
    }

    @discardableResult
    func configureContainer() -> Container {
        let container = Container.shared
        registerServices(container: container)
        return container
    }
    
    func registerServices(container: Container) {
        network = NetworkImp(session: URLSession.shared)
        
        searchRepository = SearchRepositoryMockImp(network: network)
        container.register(type: SearchRepository.self) {
            self.searchRepository
        }
    }

    override func tearDownWithError() throws {
        network = nil
        searchRepository = nil
    }

    func testSearch() throws {
        useCase.searchBookList(search: "SA")
            .sink { completion in
                if case .failure(_) = completion {
                    XCTFail()
                }
            } receiveValue: { search in
                print(search)
                XCTAssert(true)
            }
            .store(in: &cancellables)
    }
    
    func testSearchMore() throws {
        useCase.searchBookList(search: "SA", isMore: true)
            .sink { completion in
                if case .failure(_) = completion {
                    XCTFail()
                }
            } receiveValue: { search in
                print(search)
                XCTAssert(true)
            }
            .store(in: &cancellables)
    }
    
    func testBookDetail() throws {
        let useCase = BookDetailUseCase()
        
        useCase.fetchBookDetail(searchID: "testData")
            .sink { completion in
                if case .failure(_) = completion {
                    XCTFail()
                }
            } receiveValue: { search in
                print(search)
                XCTAssert(true)
            }
            .store(in: &cancellables)
    }
}

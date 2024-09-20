//
//  SearchViewModel.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Domain

import Foundation
import Combine

protocol SearchViewModelInput {
    func findSearch(text: String)
}

protocol SearchViewModelOutput {
    var bookList: CurrentValueSubject<[SearchPresentationModel], Never> { get }
    var error: PassthroughSubject<String, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    func makeSnapshot() -> SearchSnapshot
}

protocol SearchViewModelType {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelInput, SearchViewModelOutput, SearchViewModelType {
    var input: SearchViewModelInput { self }
    var output: SearchViewModelOutput { self }
    
    // MARK: - variables
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Input
    
    func findSearch(text: String) {
        SearchUseCase().searchBookList(search: text)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.isLoading.send(true)
            }, receiveCompletion: { [weak self] completion in
                self?.isLoading.send(false)
            })
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure = completion {
                    self.error.send("조회 중 오류가 발생하였습니다.")
                }
            } receiveValue: { [weak self] bookList in
                guard let self else { return }
                self.bookList.send(bookList.map {
                    SearchPresentationModel(
                        imageURL: $0.imageURL,
                        title: $0.title,
                        subTitle: $0.subTitle,
                        price: $0.price
                    )
                })
            }
            .store(in: &cancellables)

    }
    
    // MARK: - Output
    var bookList: CurrentValueSubject<[SearchPresentationModel], Never> = .init([])
    var error: PassthroughSubject<String, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
}

extension SearchViewModel {
    func makeSnapshot() -> SearchSnapshot {
        var snapshot = SearchSnapshot()
        let bookList = bookList.value
        
        snapshot.appendSections([.book])
        snapshot.appendItems(bookList.map {
            .bookInfo(
                model: $0
            )
        })
        snapshot.appendItems([.footer])
        return snapshot
    }
}


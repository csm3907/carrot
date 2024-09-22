//
//  DetailViewModel.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Domain

import Foundation
import Combine

protocol DetailViewModelInput {
    func searchDetail(id: String)
}

protocol DetailViewModelOutput {
    var bookDetail: CurrentValueSubject<BookDetail?, Never> { get }
    var error: PassthroughSubject<String, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    func makeSnapshot() -> DetailSnapshot
}

protocol DetailViewModelType {
    var input: DetailViewModelInput { get }
    var output: DetailViewModelOutput { get }
}

class DetailViewModel: DetailViewModelInput, DetailViewModelOutput, DetailViewModelType {
    var input: DetailViewModelInput { self }
    var output: DetailViewModelOutput { self }
    
    // MARK: - variables
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Input
    
    func searchDetail(id: String) {
        BookDetailUseCase().fetchBookDetail(searchID: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] detail in
                guard let self else { return }
                self.bookDetail.send(detail)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Output
    var bookDetail: CurrentValueSubject<BookDetail?, Never> = .init(nil)
    var error: PassthroughSubject<String, Never> = .init()
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
}

extension DetailViewModel {
    func makeSnapshot() -> DetailSnapshot {
        var snapshot = DetailSnapshot()
        snapshot.appendSections([.book])
        
        if let bookDetail = bookDetail.value {
            snapshot.appendItems(
                [.bookHeader(
                    model: BookHeaderModel.init(
                        title: bookDetail.title,
                        subtitle: bookDetail.subTitle,
                        authors: bookDetail.authors,
                        publisher: bookDetail.publisher,
                        image: bookDetail.imageURL
                    )
                ),
                 .bookInfo(
                    model: BookInfoModel.init(
                        year: bookDetail.year,
                        rating: bookDetail.rating,
                        desc: bookDetail.desc,
                        price: bookDetail.price,
                        url: bookDetail.url,
                        pages: bookDetail.pages
                    )
                 )
                ]
            )
            
            if bookDetail.pdf.values.count > 0 {
                snapshot.appendItems(
                    [.bookPDF(
                        model: BookPDFModel.init(
                            pdf: bookDetail.pdf
                        )
                    )]
                )
            }
        }
        
        
        return snapshot
    }
}


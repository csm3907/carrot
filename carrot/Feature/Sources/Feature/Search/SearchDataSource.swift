//
//  SearchDataSource.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit

typealias SearchDataSource = UITableViewDiffableDataSource<SearchSection, SearchItem>
typealias SearchSnapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>

enum SearchSection: Hashable {
    case book

    var itemSize: NSCollectionLayoutSize {
        return .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(80))
    }

    var contentInsets: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 20, bottom: 0, trailing: 20)
    }
}

enum SearchItem: Hashable {
    case bookInfo(model: SearchPresentationModel)
}

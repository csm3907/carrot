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
}

enum SearchItem: Hashable {
    case bookInfo(model: SearchPresentationModel)
    case footer
}

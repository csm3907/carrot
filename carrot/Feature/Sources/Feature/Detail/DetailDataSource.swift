//
//  DetailDataSource.swift
//
//
//  Created by 최승민 on 9/21/24.
//

import UIKit

typealias DetailDataSource = UITableViewDiffableDataSource<DetailSection, DetailItem>
typealias DetailSnapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>

enum DetailSection: Hashable {
    case book
}

enum DetailItem: Hashable {
    case bookHeader(model: BookHeaderModel)
    case bookInfo(model: BookInfoModel)
    case bookPDF(model: BookPDFModel)
}


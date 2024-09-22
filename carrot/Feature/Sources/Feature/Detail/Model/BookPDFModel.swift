//
//  BookPDFModel.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import Foundation

struct BookPDFModel: Hashable {
    let pdf: [String:String]
    
    static func == (lhs: BookPDFModel, rhs: BookPDFModel) -> Bool {
        if lhs.pdf == rhs.pdf { return true }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pdf)
    }
}

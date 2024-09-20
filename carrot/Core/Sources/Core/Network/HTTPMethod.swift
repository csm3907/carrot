//
//  HTTPMethod.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

//
//  MockData.swift
//  carrotTests
//
//  Created by 최승민 on 9/22/24.
//

import Foundation

enum MockData {
    static let mockRawDataSearch: String = """
    {
        "total": "48",
        "page": "1",
        "books": [
            {
                "title": "Practical MongoDB",
                "subtitle": "Architecting, Developing, and Administering MongoDB",
                "isbn13": "9781484206485",
                "price": "$32.04",
                "image": "https://itbook.store/img/books/9781484206485.png",
                "url": "https://itbook.store/books/9781484206485"
            }
        ]
    }
    """
    
    static let mockRawDataSearchMore: String = """
        {
            "total": "48",
            "page": "1",
            "books": [
                {
                    "title": "Practical MongoDB",
                    "subtitle": "Architecting, Developing, and Administering MongoDB",
                    "isbn13": "9781484206485",
                    "price": "$32.04",
                    "image": "https://itbook.store/img/books/9781484206485.png",
                    "url": "https://itbook.store/books/9781484206485"
                },
                {
                    title": "The Definitive Guide to MongoDB, 3rd Edition",
                    subtitle": "A complete guide to dealing with Big Data using MongoDB",
                    isbn13": "9781484211830",
                    price": "$47.11",
                    image": "https://itbook.store/img/books/9781484211830.png",
                    url": "https://itbook.store/books/9781484211830"
                },
                {
                    "title": "MongoDB in Action, 2nd Edition",
                    "subtitle": "Covers MongoDB version 3.0",
                    "isbn13": "9781617291609",
                    "price": "$32.10",
                    "image": "https://itbook.store/img/books/9781617291609.png",
                    "url": "https://itbook.store/books/9781617291609"
                }
            ]
        }
    """
    
    static let mockRawDataDetail: String = """
    {
        "error": "0",
        "title": "Securing DevOps",
        "subtitle": "Security in the Cloud",
        "authors": "Julien Vehent",
        "publisher": "Manning",
        "isbn10": "1617294136",
        "isbn13": "9781617294136",
        "pages": "384",
        "year": "2018",
        "rating": "5",
        "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ...",
        "price": "$26.98",
        "image": "https://itbook.store/img/books/9781617294136.png",
        "url": "https://itbook.store/books/9781617294136",
        "pdf": {
                  "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
                  "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
               }
    }
    """
}

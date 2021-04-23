//
//  HeadlinesRequestResponse.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation

struct HeadlinesRequestResponse: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}

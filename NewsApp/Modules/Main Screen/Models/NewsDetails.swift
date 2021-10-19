//
//  PhotoDetails.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation


struct NewsResponse: Codable, CodableInit {
    let status: String?
    let totalResults: Int?
    let articles: Articles?
}

// MARK: - codeArticle
struct Article: Codable, CodableInit {
    let source: Source?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - codeSource
struct Source: Codable, CodableInit {
    let id: String?
    let name: String?
}

typealias Articles = [Article]

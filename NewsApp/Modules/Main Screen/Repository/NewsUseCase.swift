//
//  PhotosOnlineDataStore.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/19/21.
//

import Foundation

typealias NewsResult = (Result<NewsResponse, Error>) -> Void

class NewsUseCase {
    
    private static let pagingLimit: Int = 20
    static var page: Int = 1
    static var shouldPage: Bool = true
    
    static func loadNews(query: String = "", result: @escaping NewsResult) {
        NewsRouter.news(page: NewsUseCase.page, limit: pagingLimit, query: query).send(NewsResponse.self, then: { response in
            switch response {
            case .failure(let error):
                result(.failure(error))
            case .success(let photosResult):
                NewsUseCase.shouldPage = self.pagingLimit <= (photosResult.articles?.count ?? 0) && page != 5 // max is 100 in this API
                NewsUseCase.page += 1
                result(.success(photosResult))
            }
        })
    }
    
    static func reset() {
        NewsUseCase.page = 1
        NewsUseCase.shouldPage = true
    }
}

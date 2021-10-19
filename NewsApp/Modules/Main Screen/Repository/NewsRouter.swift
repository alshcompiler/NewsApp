//
//  ProjectRouter.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

enum NewsRouter: URLRequestBuilder {
    case news(page: Int, limit: Int, query: String)
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .news:
            return "everything"
        }
    }

    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        case let .news(page, limit, query):
            params["page"] = "\(page)"
            params["pageSize"] = "\(limit)"
            params["apiKey"] = "ef54b50b3f0e430e9870c2cce2557882"
            params["sortBy"] = "publishedAt"
            params["q"] = query.count > 0 ? query : "apple"
            print("Page: \(page)")
            print("query: \(params["q"]!)")
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .news:
            return .get
        }
        
    }
}

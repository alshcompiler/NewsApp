//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewsAPI() throws {
        
        let promise = expectation(description: "data retrieved!")
        var responseError: Error?
        var dataRetrieved: Bool = false
        let query = "apple"
        NewsUseCase.loadNews(query: query) { response in
            switch response {
            case .failure(let error): // show alert
                responseError = error
                // TODO: - show some error
            case .success(let newsResult):
                dataRetrieved = (newsResult.articles?.count ?? 0) > 0
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 15) // api is not fast usually i give timeout 5 seconds only

        XCTAssertNil(responseError)
        XCTAssertTrue(dataRetrieved)
    }
    
    func testPagingViolationAPI() throws {
        
        let promise = expectation(description: "data less than or equal to 20 item")
        var responseError: Error?
        var dataRetrievedWithPaging: Bool = false
        let maximumNewsLimit = 20
        let query = "apple"
        NewsUseCase.loadNews(query: query) { response in
            switch response {
            case .failure(let error): // show alert
                responseError = error
                // TODO: - show some error
            case .success(let newsResult):
                let resultCount: Int = newsResult.articles?.count ?? 0
                dataRetrievedWithPaging = resultCount > 0 && resultCount <= maximumNewsLimit
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 15) // api is not fast usually i give timeout 5 seconds only

        XCTAssertNil(responseError)
        XCTAssertTrue(dataRetrievedWithPaging)
    }

}

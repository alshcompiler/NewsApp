//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation
import SVProgressHUD

protocol HomeView: NSObjectProtocol { 
    func reloadData()
}

class HomePresenter {
    
    private weak var view: HomeView!
    
    private let pagingThreshold: Int = 2
    
    var isLoading: Bool = false
    
    var news: Articles = []
    
    init(view: HomeView) {
        self.view = view
    }
    
    func resetNews() {
        news = []
        NewsUseCase.reset() // reset paging
        view.reloadData()
    }
    
    func getNews(query: String = "") {
        if !NewsUseCase.shouldPage {return}
        isLoading = true
        SVProgressHUD.show() // should have used infinite scrolling hud, maybe later :D
        NewsUseCase.loadNews(query: query) { [weak self] response in
            guard let self = self else {return}
            self.isLoading = false
            SVProgressHUD.dismiss()
            switch response {
            case .failure(_): // show alert
                break
                // TODO: - show some error
            case .success(let newsResult):
                self.news.append(contentsOf: newsResult.articles ?? [])
                self.view.reloadData()
            }
        }
    }
    
    func goNextPage(index: Int, query: String = "") {
        
        if index + pagingThreshold == news.count { // to start paging before reaching last cell
            print("threshold =  \(index)")
            getNews(query: query)
        }
    }
}

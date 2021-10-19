//
//  DetailsRouter.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/21/21.
//

import Foundation

protocol DetailsRoute {
    func instantiate(news: Article, image: UIImage) -> DetailsViewController
}

extension DetailsRoute where Self: UIViewController {
    func instantiate(news: Article, image: UIImage) -> DetailsViewController {
        let storyboard = UIStoryboard(storyboard: .main) 
        let viewController: DetailsViewController = storyboard.instantiateViewController()
        viewController.news = news
        viewController.newsImage = image
        return viewController
    }
}

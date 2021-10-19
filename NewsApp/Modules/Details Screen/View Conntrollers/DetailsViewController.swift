//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/18/21.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController, DetailsRoute {
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    @IBOutlet private weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    
    @IBOutlet weak var sourceURLTextView: UITextView!
    
    var news: Article?
    var newsImage: UIImage = UIImage()
    
    let urlNumberOflines: Int = 2
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        //news.publishedAt?.formatted()
    }
    
    private func configureUI() {
        newsImageView.image = newsImage
        let dominantColor = newsImage.dominantColor ?? UIColor() // to avoid generating it twice below
        view.backgroundColor = dominantColor
        navigationController?.navigationBar.barTintColor = dominantColor
        
        sourceURLTextView.textContainer.maximumNumberOfLines = urlNumberOflines
        sourceURLTextView.textContainer.lineBreakMode = .byTruncatingTail
        newsTitleLabel.text = news?.title
        authorLabel.text = news?.author
        newsDescriptionLabel.text = news?.articleDescription
        newsContentLabel.text = news?.content
        newsDateLabel.text = news?.publishedAt?.formatted()
        sourceURLTextView.text = news?.url
    }

}

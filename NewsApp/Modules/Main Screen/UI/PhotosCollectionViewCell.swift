//
//  PhotosCollectionViewCell.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit
import AlamofireImage

class PhotosCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "\(PhotosCollectionViewCell.self)"
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    func configure(_ news: Article) {
        self.contentView.roundCorners()
        loadImage(news)
        authorLabel.text = news.title
    }

//    
    fileprivate func loadImage(_ news: Article) {
        guard let urlString = news.urlToImage else {
            self.photoImageView.image = #imageLiteral(resourceName: "galleryPlaceholder")
            return
        }
        guard let url = URL(string: urlString) else {return}
        let filter: AspectScaledToFillSizeFilter = AspectScaledToFillSizeFilter(size: CGSize(width: screenWidth, height: screenWidth * 0.7))
        photoImageView.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "galleryPlaceholder"),filter: filter, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false)
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.af.cancelImageRequest()
        photoImageView.image = nil
     }
}

//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var photosCollectionView: UICollectionView!
    
    private let searchController = UISearchController()
    
    private var searchText: String = ""

    private var presenter: HomePresenter!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = nil // remove tint color 
    }
    
    // MARK: - Helper Methods
    
    fileprivate func setupView() {
        configureCollectionView()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    private func configureCollectionView() {
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: PhotosCollectionViewCell.cellIdentifier)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }

    private func setupPresenter() {
        presenter = HomePresenter(view: self)
        presenter.getNews()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell else {return}
        guard let image = cell.photoImageView.image else {return}
        let news = presenter.news[indexPath.row]
        let viewController: DetailsViewController = DetailsViewController()
        navigationController?.pushViewController(viewController.instantiate(news: news, image: image), animated: true)
//        present(viewController.instantiate(image: photo), animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        preloadNext(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.cellIdentifier, for: indexPath) as! PhotosCollectionViewCell
        let news = presenter.news[indexPath.row]
        cell.configure(news)
        return cell
    }
    
    fileprivate func preloadNext(_ indexPath: IndexPath) {
        print(indexPath.row)
        if !presenter.isLoading {
            presenter.goNextPage(index: indexPath.row, query: searchText)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1 // in case you want to make +1 columns
        let spacing: CGFloat = 10 * columns // no need to handle columns = 1
        let collectionViewMargin: CGFloat = 8.0 * 2 // both sides
        let totalSpacing: CGFloat = spacing + collectionViewMargin
        let cellWidth  = (view.frame.width - totalSpacing)/columns
        let cellHeight = cellWidth * 0.7 // modify if needed
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HomeViewController: HomeView {
    func reloadData() {
        photosCollectionView.reloadData()
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count >= 0, self.searchText != searchText else {
            searchController.isActive = false
            return
        }
        searchController.dismiss(animated: true, completion: nil)
        search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("") // reset for orriginal search: apple keyword
    }
    
    fileprivate func search(_ searchText: String) {
        self.searchText = searchText
        self.presenter.resetNews()
        self.presenter.getNews(query: searchText)
    }
    
}

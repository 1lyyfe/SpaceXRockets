//
//  SearchViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    var viewModel = SearchViewModel()
    
    private lazy var refreshControl: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        r.tintColor = .black
        return r
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        RocketSummaryCollectionCell.register(in: cv)
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.keyboardDismissMode = .onDrag
        return cv
    }()
    
    private lazy var navTitleStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [navTitleViewImage])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 6
        return s
    }()
    
    private lazy var navTitleViewImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "rocket icon")
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        return i
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.placeholder = "Search Rocket..." //localise
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var numberOfResultsLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "NUMBER_OF_SEARCH_RESULTS".localised()
        l.font = UIFont.app_RobotoRegular(size: 14)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        bindViewModel()
        searchBar.delegate = self
        reloadData()
    }
        
    func configureNavBar() {
        navigationItem.titleView = navTitleStackView
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        configureNavBar()
        
        collectionView.refreshControl = refreshControl
        
        view.add(searchBar, numberOfResultsLabel, collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            numberOfResultsLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            numberOfResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            collectionView.topAnchor.constraint(equalTo: numberOfResultsLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    func bindViewModel() {
        viewModel.addAction(for: self, event: .error) {
            [weak self] (error: Error) in
            self?.coordinator?.presentErrorMessage(error.localizedDescription)
        }
        
        viewModel.addAction(for: self, event: .rocketsUpdated) {
            [weak self] (resultsCount: Int) in
            self?.numberOfResultsLabel.text = "NUMBER_OF_SEARCH_RESULTS".localised(with: [resultsCount])
            self?.collectionView.reloadData()
        }
        
        viewModel.addAction(for: self, event: .networkActivity) { [weak self] (isActive: Bool) in
            guard !isActive else {
                self?.showLoadingSpinner()
                return
            }
            
            self?.hideLoadingSpinner()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing: CGFloat = 4 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    private lazy var loadingSpinner = SpinnerViewController()
    
    func showLoadingSpinner() {
        addChild(loadingSpinner)
        loadingSpinner.view.frame = view.frame
        view.addSubview(loadingSpinner.view)
        loadingSpinner.didMove(toParent: self)
    }
    
    func hideLoadingSpinner() {
        loadingSpinner.willMove(toParent: nil)
        loadingSpinner.view.removeFromSuperview()
        loadingSpinner.removeFromParent()
    }
    
    // MARK: - Actions
    
    @objc func reloadData() {
        viewModel.getRockets()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rockets.isEmpty ? 0 : self.viewModel.rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RocketSummaryCollectionCell.dequeue(from: collectionView, for: indexPath)
        cell.configData(data: viewModel.getDataAtIndex(index: indexPath.row))
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Item at index: \(indexPath.row) tapped")
        coordinator?.presentRocketDetail(vm: viewModel.getRocketDetailAtIndex(index: indexPath.row))
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width-16, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing*2, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}

extension SearchViewController: UISearchBarDelegate {
    //add some check here with timer to ensure api not hammered constantly! - Future enhancement
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchRocket(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.searchRocket(text)
    }
}

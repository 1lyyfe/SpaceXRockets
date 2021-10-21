//
//  HomeViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit
import WebKit

class HomeViewController: ViewController {
    
    var coordinator: MainCoordinator?
    
    var viewModel = HomeViewModel()
    
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        bindViewModel()
        reloadData()
    }
    
    func configureNavBar() {
        navigationItem.titleView = navTitleStackView

        let filterButton = UIBarButtonItem(image: UIImage(named: "filter icon")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: self,
                                           action: #selector(showFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        configureNavBar()
        
        collectionView.refreshControl = refreshControl
        
        view.add(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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
            [weak self] in
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
    
    //TO DO in the future
    @objc func showFilters() {
        debugPrint("Show Filters!")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rockets.isEmpty ? 0 : self.viewModel.rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RocketSummaryCollectionCell.dequeue(from: collectionView, for: indexPath)
        cell.configData(data: viewModel.getDataAtIndex(index: indexPath.row))
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Item at index: \(indexPath.row) tapped")
        coordinator?.presentRocketDetail(vm: viewModel.getRocketDetailAtIndex(index: indexPath.row))
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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

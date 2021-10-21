//
//  RocketImagesCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class RocketImagesCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        RocketImagesCollectionViewCell.register(in: cv)
        RocketNoImagesCollectionViewCell.register(in: cv)
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.isUserInteractionEnabled = true
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.currentPage = 0
        p.tintColor = UIColor.red
        p.pageIndicatorTintColor = UIColor.lightGray
        p.currentPageIndicatorTintColor = UIColor.black
        p.isUserInteractionEnabled = true
        return p
    }()
    
    private lazy var containingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var images: [String]? {
        didSet {
            collectionView.reloadData()

        }
    }
    
    func configureData(images: [String]?) {
        self.images = images
    }
    
    // MARK: - Setup
    
    func setupUI(){
        containingView.styleView()
        
        self.selectionStyle = .none
        contentView.addSubview(containingView)
        
        containingView.addSubview(collectionView)
        containingView.addSubview(pageControl)
    
        containingView.pinToView(contentView, inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containingView.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: containingView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: containingView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 260),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: containingView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            pageControl.bottomAnchor.constraint(equalTo: containingView.bottomAnchor, constant: -16)
        ])
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    // MARK: - Cell reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension RocketImagesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = self.images?.count ?? 0
        return self.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let images = self.images, !images.isEmpty else {
            let cell = RocketNoImagesCollectionViewCell.dequeue(from: collectionView, for: indexPath)
            return cell
        }
        
        let cell = RocketImagesCollectionViewCell.dequeue(from: collectionView, for: indexPath)
        cell.imageView.loadImageUsingCacheWithUrlString(images[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl.currentPage = Int(roundedIndex)
    }
}

extension RocketImagesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension RocketImagesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: frame.width-16, spacing: LayoutConstantDetailedView.spacing)
        return CGSize(width: width, height: LayoutConstantDetailedView.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstantDetailedView.spacing, left: 0, bottom: LayoutConstantDetailedView.spacing, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstantDetailedView.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstantDetailedView.spacing
    }
}


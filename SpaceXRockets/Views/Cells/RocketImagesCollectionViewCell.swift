//
//  RocketImagesCollectionViewCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit


class RocketImagesCollectionViewCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "spaceX placeholder")
        i.contentMode = .scaleAspectFit
        i.layer.cornerRadius = 12
        i.layer.cornerCurve = .continuous
        i.clipsToBounds = true
        return i
    }()
        
    private let imageHeight: CGFloat = 260
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        contentView.addSubview(imageView)
                
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Cell reuse
    
    override open func prepareForReuse() {
        super.prepareForReuse()
    }
}

//
//  RocketNoImagesCollectionViewCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class RocketNoImagesCollectionViewCell: UICollectionViewCell {
        
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "spaceX placeholder")
        i.contentMode = .scaleAspectFill
        i.layer.cornerRadius = 12
        i.layer.cornerCurve = .continuous
        i.clipsToBounds = true
        return i
    }()
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(imageView)
        imageView.pinToParentView()
    }
}

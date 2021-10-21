//
//  RocketSummaryCollectionCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit
import Kingfisher

class RocketSummaryCollectionCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "spaceX placeholder")
        i.contentMode = .scaleAspectFill
        i.ratio(1).isActive = true
        i.width(118).isActive = true
        i.layer.cornerRadius = 59
        i.clipsToBounds = true
        i.layer.borderWidth = 3.0
        i.layer.borderColor = UIColor.white.cgColor
        return i
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_MontHeavy(size: 22)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()
    
    private lazy var countryLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_RobotoRegular(size: 16)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()
    
    private lazy var companyLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_RobotoRegular(size: 16)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()
    
    private lazy var activeFlag: ActiveFlagView = {
        let flag = ActiveFlagView()
        flag.translatesAutoresizingMaskIntoConstraints = false
        return flag
    }()
    
    private let imageHeight: CGFloat = 50.0
    
    var imageUrlString: String? {
        didSet {
            guard let urlString = imageUrlString, let url = URL(string: urlString) else {
                imageView.image = nil
                return
            }
            
            imageView.kf.setImage (with: url, options: [.forceTransition, .transition(.fade(0.2))])
        }
    }
    
    var name: String? {
        didSet {
            guard let n = self.name else { return }
            titleLabel.text = n
        }
    }
    
    var country: String? {
        didSet {
            guard let c = self.country else { return }
            countryLabel.text = c
        }
    }
    
    var company: String? {
        didSet {
            guard let c = self.company else { return }
            companyLabel.text = c
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configData(data: RocketSimpleDetail) {
        self.imageUrlString = data.image
        self.name = data.name
        self.company = data.company
        self.country = data.country
        self.activeFlag.setStatus(data.active == true ? .active : .nonActive)
    }
    
    func setup() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        backgroundColor = .white
        
        contentView.add(imageView, titleLabel, countryLabel, companyLabel, activeFlag)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                        
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            companyLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            countryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            countryLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            activeFlag.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            activeFlag.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            activeFlag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
}

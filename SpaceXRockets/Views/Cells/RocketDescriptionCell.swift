//
//  RocketDescriptionCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class RocketDescriptionCell: UITableViewCell {
    
    private lazy var containingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_RobotoRegular(size: 14)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    func configureData(description: String?) {
        descriptionLabel.text = description ?? "DESCRIPTION_NOT_AVAILABLE".localised()
    }
    
    // MARK: - Setup
    
    func setupUI(){
        containingView.styleView()
        
        self.selectionStyle = .none
        contentView.addSubview(containingView)
        
        containingView.addSubview(descriptionLabel)
    
        containingView.pinToView(contentView, inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        descriptionLabel.pinToView(containingView, inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }

    
    // MARK: - Cell reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

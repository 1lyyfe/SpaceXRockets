//
//  RocketMetaCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class RocketMetaCell: UITableViewCell {
    
    private lazy var containingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.alignment = .leading
        s.axis = .vertical
        s.spacing = 10
        return s
    }()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    func configureData(meta: RocketDetailMeta) {
        
        if let type = meta.type {
            let l = createLabel(title: "TYPE".localised(), type)
            stackView.addArranged(l)
        }
        
        if let stages = meta.stages {
            let l = createLabel(title: "STAGES".localised(), "\(stages)")
            stackView.addArranged(l)
        }
        
        if let boosters = meta.boosters {
            let l = createLabel(title: "BOOSTERS".localised(), "\(boosters)")
            stackView.addArranged(l)
        }
        
        if let cost = meta.costPerLaunch {
            let l = createLabel(title: "COST_PER_LAUNCH".localised(), "\(cost)")
            stackView.addArranged(l)
        }
        
        if let pct = meta.pctSuccessRate {
            let l = createLabel(title: "SUCCESS_PCT".localised(), "\(pct)")
            stackView.addArranged(l)
        }
        
        if let ff = meta.firstFlight {
            let l = createLabel(title: "FIRST_FLIGHT".localised(), ff)
            stackView.addArranged(l)
        }
    }
    
    // MARK: - Setup
    
    func setupUI(){
        containingView.styleView()
        
        self.selectionStyle = .none
        contentView.addSubview(containingView)
        
        containingView.addSubview(stackView)
    
        containingView.pinToView(contentView, inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        stackView.pinToView(containingView, inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func createLabel(title: String, _ value: String) -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_RobotoRegular(size: 14)
        l.textColor = .black
        l.textAlignment = .left
        l.text = title + " " + value
        return l
    }

    
    // MARK: - Cell reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

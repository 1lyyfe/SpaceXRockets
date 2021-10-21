//
//  ActiveFlagView.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class ActiveFlagView: UIStackView {
    
    private lazy var statusLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.app_RobotoRegular(size: 12)
        l.textColor = .black
        l.numberOfLines = 1
        l.textAlignment = .left
        return l
    }()
    
    private lazy var iconView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green
        v.layer.cornerRadius = 6
        v.clipsToBounds = true
        v.layer.borderWidth = 2.0
        v.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            v.width(12),
            v.height(12)
        ])
        
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        buildViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ActiveState {
        case active
        case nonActive
    }
    
    private func buildViews() {
        axis = .horizontal
        alignment = .center
        addArranged(iconView, statusLabel)
        spacing = 6
        
        setStatus()
    }
    
    func setStatus( _ state: ActiveState = .active) {
        statusLabel.text = state == .active ? "ACTIVE".localised() : "NOT_ACTIVE".localised()
        iconView.backgroundColor = state == .active ? .green : .red
    }
}

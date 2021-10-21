//
//  UIStackView+Extra.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit

extension UIStackView {

    func addArranged(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        })
    }
    
    func addArranged(_ views: [UIView]) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        })
    }

    func removeAllArranged() {
        arrangedSubviews.forEach({$0.removeFromSuperview()})
    }
}


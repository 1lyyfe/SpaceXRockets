//
//  UIView+Constraints.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import UIKit

extension UIView {

    func add(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }

    func removeAll() {
        subviews.forEach({$0.removeFromSuperview()})
    }

    func left(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> NSLayoutConstraint {
        return leftAnchor.constraint(equalTo: anchor, constant: constant)
    }

    func right(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> NSLayoutConstraint {
        return rightAnchor.constraint(equalTo: anchor, constant: constant)
    }

    func top(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: anchor, constant: constant)
    }

    func bottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> NSLayoutConstraint {
        return bottomAnchor.constraint(equalTo: anchor, constant: constant)
    }

    func width(_ constant: CGFloat) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalToConstant: constant)
    }

    func height(_ constant: CGFloat) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalToConstant: constant)
    }

    func ratio(_ ratio: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let c = widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio)
        c.priority = priority
        return c
    }

    func pinToParentView(_ inset: UIEdgeInsets = .zero) {
        if let parent = superview {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor, constant: inset.top),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: inset.left),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -inset.right),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -inset.bottom)
            ])
        }
    }

    func pinToView(_ view: UIView, inset: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom)
        ])
    }
    
    func styleView() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }

}

extension NSLayoutAnchor {
    @objc func pin(to other: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.constraint(equalTo: other, constant: constant)
    }
}

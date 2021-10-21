//
//  StackableViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit

class StackableViewController: UIViewController {

    final lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    final lazy var headerStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.translatesAutoresizingMaskIntoConstraints = false
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 0).isActive = true // hack to make header start at 0
        s.addArrangedSubview(v)
        return s
    }()

    final lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 8
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    final lazy var footerStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.translatesAutoresizingMaskIntoConstraints = false
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 0).isActive = true // hack to make header start at 0
        s.addArrangedSubview(v)
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.addSubview(scrollView)
        view.addSubview(headerStackView)
        view.addSubview(footerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            footerStackView.top(to: scrollView.bottomAnchor),
            footerStackView.left(to: view.leftAnchor),
            footerStackView.right(to: view.rightAnchor),
            footerStackView.bottom(to: view.bottomAnchor)
        ])
        scrollView.addSubview(stackView)
        stackView.pinToParentView()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

    }

    func lineView(_ thickness: CGFloat = 1, colour: UIColor? = .white) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.height(thickness).isActive = true
        v.backgroundColor = colour
        return v
    }
}

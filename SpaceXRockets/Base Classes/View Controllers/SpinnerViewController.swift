//
//  SpinnerViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    
    private lazy var spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(style: .large)
        s.color = .green
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

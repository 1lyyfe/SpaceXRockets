//
//  RootCoordinator.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import UIKit

class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
    var rootViewController: UIViewController? {
        navigationController?.viewControllers.first
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
}

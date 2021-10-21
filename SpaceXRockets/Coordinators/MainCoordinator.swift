//
//  MainCoordinator.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import FeedKit

class MainCoordinator: RootCoordinator {
    
    func presentRocketDetail(vm: RocketDetailViewModel) {
        guard let nav = navigationController else { return }
        
        let vc = RocketDetailViewController()
        vc.viewModel = vm
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        
        nav.view.layer.add(transition, forKey: nil)
        nav.pushViewController(vc, animated: true)
    }
}

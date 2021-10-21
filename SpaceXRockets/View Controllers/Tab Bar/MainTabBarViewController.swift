//
//  MainTabBarViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.barTintColor = .white
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    private lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController()
        return vc
    }()

    private lazy var searchViewController: SearchViewController = {
        let vc = SearchViewController()
        return vc
    }()

    func setup() {
        let homeTab = CustomNavigationController(rootViewController: homeViewController)
        let homeTabItem = UITabBarItem(title: nil, image: UIImage(named: "home tab icon.png"), selectedImage: UIImage(named: "home tab icon.png"))
      
        homeTab.tabBarItem = homeTabItem
        homeViewController.coordinator = MainCoordinator(navigationController: homeTab)

        let searchTab = CustomNavigationController(rootViewController: searchViewController)
        let searchTabItem = UITabBarItem(title: nil, image: UIImage(named: "search tab icon.png"), selectedImage: UIImage(named: "search tab icon.png"))
      
        searchTab.tabBarItem = searchTabItem
        searchViewController.coordinator = MainCoordinator(navigationController: searchTab)

        setViewControllers([homeTab, searchTab], animated: false)
        selectedIndex = 0
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }
}
